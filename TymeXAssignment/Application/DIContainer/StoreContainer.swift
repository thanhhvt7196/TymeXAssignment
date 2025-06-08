//
//  StoreContainer.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Swinject
import SwiftData

struct StoreContainer: DIContainer {
    private static let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GithubUserSwiftData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    static var container: Container {
        let container = Container()
        
        container.register(UserStore.self) { _ in
            return UserStoreImpl(collection: SwiftDataStore<GithubUserSwiftData>(modelContext: ModelContext(sharedModelContainer)))
        }
        .inObjectScope(.container)
        
        return container
    }
}
