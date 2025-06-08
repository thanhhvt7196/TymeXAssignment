# iOS Development Guidelines

## 1. Language

We use **[Swift](https://developer.apple.com/swift/)** as our primary development language, leveraging modern Apple frameworks and technologies for building robust iOS applications.

### 1.1 Swift

We use **[Xcode 16.4](https://developer.apple.com/xcode/)** as our primary development environment, taking advantage of the latest Swift features and modern frameworks:

- **[SwiftUI](https://developer.apple.com/xcode/swiftui/)**: Apple's modern declarative framework for building user interfaces across all Apple platforms
- **[SwiftData](https://developer.apple.com/documentation/swiftdata)**: The next generation of data persistence framework that seamlessly integrates with SwiftUI

Useful links:
- [Swift](https://developer.apple.com/swift/)
- [Swift.org - Welcome to Swift](https://swift.org/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [SwiftData Documentation](https://developer.apple.com/documentation/swiftdata)

### 1.2 Modern iOS Development

Our development approach focuses on simplicity and efficiency using SwiftUI:

- **SwiftUI First**: Building modern, declarative user interfaces with SwiftUI's built-in state management
- **Observable Pattern**: Using simple Observable objects for state management and data flow
- **Swift Concurrency**: Leveraging async/await for clean, efficient asynchronous operations
- **SwiftData**: Native data persistence that integrates seamlessly with SwiftUI

We embrace SwiftUI's simplicity while maintaining clean, maintainable code that follows Apple's best practices.

## 2. Architecture

The project follows a simple and efficient architecture leveraging SwiftUI's built-in features:

### 2.1 View and State Management

Our architecture follows a unidirectional data flow pattern where Views are driven by Observable state:

```
    ┌─────────────────┐                ┌───────────────────┐             ┌────────────────┐
    │                 │      owns      │                   │    owns     │                │
    │  SwiftUI View   │◀──────────────>│    @Observable    │────────────>│   Model Data   │
    │                 │  Data Binding  │                   │             │                │
    └─────────────────┘                └───────┬───────────┘             └───────┬────────┘
                                               ▲                                 │
                                               │                                 │
                                               │             Notifies            │
                                               └─────────────────────────────────┘
```

**Key Components:**
- **SwiftUI Views**: Declarative UI components that render the interface (`UserListView`, `UserDetailView`)
- **Observable Objects**: State containers that manage data and business logic (`UserListObservable`, `UserDetailObservable`)
- **Model**: Data structures and persistence layer using SwiftData

**Data Flow:**

1. Views observe state from Observable objects using SwiftUI's property wrappers:
   - `@State` for local view state
   - `@StateObject` for observable object instances
   - `@EnvironmentObject` for shared dependencies
   - `@Binding` for passing mutable state

```swift
struct UserListView: View {
    // Environment object for navigation
    @EnvironmentObject private var router: Router
    
    // State object for business logic
    @State private var userListObservable: UserListObservable
    
    init(service: UserService = ServiceContainer.get(), 
         modelContainer: ModelContainer = ServiceContainer.get()) {
        _userListObservable = State(wrappedValue: 
            UserListObservable(service: service, modelContainer: modelContainer))
    }
}
```

2. User actions in Views trigger methods in Observable objects

```swift
List {
    ForEach(userListObservable.userList) { user in
        PlainListCell {
            UserListItemView(user: user)
        }
        .onTapGesture {
            // User action triggering navigation
            router.path.append(RouterPath.userDetail(user))
        }
        .onAppear {
            // User action triggering data loading
            if user == userListObservable.userList.last {
                Task {
                    await userListObservable.loadMore()
                }
            }
        }
    }
}
.refreshable {
    // Pull-to-refresh action
    await userListObservable.loadFirstPage(needLoading: false)
}
```

3. Observable objects update their state and model data

```swift
final class UserListObservable: ObservableObject {
    // Published properties for state management
    @Published private(set) var userList: [GitHubUser] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    @MainActor
    func loadFirstPage(needLoading: Bool = true) async {
        do {
            isLoading = needLoading
            currentPage = 1
            // Update state with new data
            userList = try await service.getUsers(page: currentPage)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
```

4. SwiftUI automatically re-renders Views when observed state changes

```swift
var body: some View {
    NavigationStack(path: $router.path) {
        // View automatically updates when isLoading or userList changes
        if userListObservable.isLoading && userListObservable.userList.isEmpty {
            skeletonView  // Shows loading state
        } else {
            listView     // Shows content
                .accessibilityIdentifier("userList")
        }
    }
}
```

### 2.2 Project Structure

The project follows a modular structure that separates concerns and promotes maintainability:

```
TymeXAssignment/
├── Application/                    # App bootstrap and configuration
│   ├── DIContainer/               # Dependency injection setup
│   ├── AppDelegate.swift          # App lifecycle and SwiftData setup
│   └── TymeXAssignmentApp.swift   # SwiftUI app entry point
│
├── Presentation/                  # UI Layer
│   ├── Screens/                  # Main app screens
│   ├── CustomViews/             # Reusable UI components
│   └── Coordinator/             # Navigation management
│
├── Domain/                       # Business logic and models
│   ├── Entities/               # Core business models
│   └── Services/               # Service interfaces
│
├── Data/                        # Data access layer
│   ├── Model/                  # SwiftData persistence models
│   └── Services/               # Service implementations
│
├── Infrastructure/              # Cross-cutting concerns
│   └── Network/                # Network setup and configuration
│
├── Common/                      # Shared utilities
│   ├── Extensions/             # Swift extensions
│   └── Utils/                  # Helper functions
│
└── Resources/                   # App resources
    ├── Assets.xcassets/        # Images and colors
    ├── Fonts/                  # Custom TT Norms Pro fonts
    ├── Localization/          # Localized strings and resources
    └── Generated/              # SwiftGen generated resources
```

**Key Aspects:**
- **Clean Separation**: Each directory has a single responsibility
- **Feature Organization**: Screens and components are grouped logically
- **Model Layer Separation**:
  - Domain Models: Pure Swift types for business logic
  - Persistence Models: SwiftData models for storage
- **Resource Management**: Generated code for type-safe asset access
- **Scalability**: Structure supports adding new features without modification
- **Testability**: Clear boundaries make testing easier

### 2.3 Navigation

The project's navigation is implemented using SwiftUI NavigationStack with a centralized Router:

1. **Router Definition**
```swift
class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    enum RouterPath: Hashable {
        case userDetail(GitHubUser)
    }
}
```

2. **Router Setup in App**
```swift
@main
struct TymeXAssignmentApp: App {
    @StateObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(router)
        }
    }
}
```

3. **Usage in UserListView**
```swift
struct UserListView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationStack(path: $router.path) {
            List {
                ForEach(users) { user in
                    UserListItemView(user: user)
                        .onTapGesture {
                            // Navigate to user detail
                            router.path.append(RouterPath.userDetail(user))
                        }
                }
            }
            .navigationDestination(for: RouterPath.self) { route in
                switch route {
                case .userDetail(let user):
                    UserDetailView(user: user)
                }
            }
        }
    }
}
```

4. **Back Navigation**
```swift
// Back to previous screen
router.path.removeLast()

// Back to root view
router.path.removeLast(router.path.count)
```

### 2.4 Dependency Injection
The project uses **[Swinject](https://github.com/Swinject/Swinject)** to manage dependency injection:

1. **Container Setup**
```swift
struct ServiceContainer: DIContainer {
    static var container: Container {
        let container = Container()
        
        container.register(APIClient.self) { _ in
            APIClientImpl()
        }
        .inObjectScope(.container)
        
        container.register(UserService.self) { _ in
            UserServiceImpl()
        }
        .inObjectScope(.transient)
        
        container.register(ModelContainer.self) { _ in
            AppDelegate.sharedModelContainer
        }
        .inObjectScope(.container)
        
        return container
    }
}

```

2. **Service Container**
```swift
extension DIContainer {
    static func send<T>(_ value: T, withKey key: String) {
        container.register(T.self, name: key) { _ -> T in
            return value
        }
    }
    
    static func get<T>(key: String? = nil) -> T {
        guard let t = container.resolve(T.self, name: key) else {
            fatalError("Could not resolve dependency for key: \(key ?? "unknown")")
        }
        return t
    }
    
    static func get<T, P>(arg: P, key: String?) -> T {
        guard let t = container.resolve(T.self, name: key, argument: arg) else {
            fatalError("Could not resolve dependency for key: \(key ?? "unknown")")
        }
        return t
    }
}

```

3. **Inject Dependencies**
```swift
struct UserDetailView: View {
    @State private var userDetailObservable: UserDetailObservable
    
    init(userService: UserService = ServiceContainer.get(),
         modelContainer: ModelContainer = ServiceContainer.get()) {
        _userDetailObservable = State(wrappedValue: 
            UserDetailObservable(userService: userService, modelContainer: modelContainer))
    }
}
```

## 3. Third-party libraries

The project uses the following libraries:

### Dependency Injection
- **[Swinject](https://github.com/Swinject/Swinject)**: A lightweight dependency injection framework for Swift

### Networking
- **[Alamofire](https://github.com/Alamofire/Alamofire)**: Elegant HTTP networking library

### Image Loader
- **[Kingfisher](https://github.com/onevcat/Kingfisher)**: Powerful image downloading and caching library

### Development Tools
- **[SwiftGen](https://github.com/SwiftGen/SwiftGen)**: A tool that auto-generates Swift code for resources (images, strings, fonts, etc.)
- **[Pulse](https://github.com/kean/Pulse)**: Network and console logging inspector for iOS apps. Access by shaking device or using Cmd + Ctrl + Z in Simulator
