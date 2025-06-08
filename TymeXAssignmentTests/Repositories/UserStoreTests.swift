import XCTest
@testable import TymeXAssignment
import SwiftData

@MainActor
final class UserStoreTests: XCTestCase {
    var modelContainer: ModelContainer!
    var modelContext: ModelContext!
    var userStore: UserStoreImpl<SwiftDataStore<GithubUserSwiftData>>!
    
    override func setUp() async throws {
        let schema = Schema([GithubUserSwiftData.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        modelContext = ModelContext(modelContainer)
        userStore = UserStoreImpl(collection: SwiftDataStore(modelContext: modelContext))
    }
    
    override func tearDown() async throws {
        userStore.clean()
        modelContext = nil
        modelContainer = nil
        userStore = nil
        try? await super.tearDown()
    }
    
    func testAddUsers_ShouldSaveToStore() {
        let users = GitHubUser.mockList()
        
        userStore.add(users: users)
        
        let storedUsers = userStore.getAllUsers()
        XCTAssertEqual(storedUsers.count, users.count)
        XCTAssertEqual(storedUsers[0].login, GitHubUser.mock().login)
        XCTAssertEqual(storedUsers[0].id, GitHubUser.mock().id)
        XCTAssertEqual(storedUsers[1].login, GitHubUser.mock2().login)
        XCTAssertEqual(storedUsers[1].id, GitHubUser.mock2().id)
    }
    
    func testGetAllUsers_WhenEmpty_ShouldReturnEmptyArray() {
        let users = userStore.getAllUsers()
        
        XCTAssertTrue(users.isEmpty)
    }
    
    func testGetAllUsers_ShouldReturnSortedById() {
        let users = [
            GitHubUser.mock3(),
            GitHubUser.mock(),
            GitHubUser.mock2()
        ]
        userStore.add(users: users)
        
        let storedUsers = userStore.getAllUsers()
        
        XCTAssertEqual(storedUsers.count, users.count)
        XCTAssertEqual(storedUsers[0].id, GitHubUser.mock().id)
        XCTAssertEqual(storedUsers[0].login, GitHubUser.mock().login)
        XCTAssertEqual(storedUsers[1].id, GitHubUser.mock2().id)
        XCTAssertEqual(storedUsers[1].login, GitHubUser.mock2().login)
        XCTAssertEqual(storedUsers[2].id, GitHubUser.mock3().id)
        XCTAssertEqual(storedUsers[2].login, GitHubUser.mock3().login)
    }
    
    func testClean_ShouldRemoveAllUsers() {
        let users = GitHubUser.mockList()

        userStore.add(users: users)
        XCTAssertEqual(userStore.getAllUsers().count, users.count)
        
        userStore.clean()
        XCTAssertTrue(userStore.getAllUsers().isEmpty)
    }
    
    func testAddUsers_WithAllFields_ShouldPreserveData() {
        let user = GitHubUser.mock()
        
        userStore.add(users: [user])
        
        let storedUser = userStore.getAllUsers().first
        XCTAssertNotNil(storedUser)
        XCTAssertEqual(storedUser?.login, GitHubUser.mock().login)
        XCTAssertEqual(storedUser?.id, GitHubUser.mock().id)
        XCTAssertEqual(storedUser?.nodeId, GitHubUser.mock().nodeId)
        XCTAssertEqual(storedUser?.avatarUrl, GitHubUser.mock().avatarUrl)
        XCTAssertEqual(storedUser?.gravatarId, GitHubUser.mock().gravatarId)
        XCTAssertEqual(storedUser?.url, GitHubUser.mock().url)
        XCTAssertEqual(storedUser?.htmlUrl,GitHubUser.mock().htmlUrl)
        XCTAssertEqual(storedUser?.followersUrl, GitHubUser.mock().followersUrl)
        XCTAssertEqual(storedUser?.followingUrl, GitHubUser.mock().followingUrl)
        XCTAssertEqual(storedUser?.gistsUrl, GitHubUser.mock().gistsUrl)
        XCTAssertEqual(storedUser?.starredUrl, GitHubUser.mock().starredUrl)
        XCTAssertEqual(storedUser?.subscriptionsUrl, GitHubUser.mock().subscriptionsUrl)
        XCTAssertEqual(storedUser?.organizationsUrl, GitHubUser.mock().organizationsUrl)
        XCTAssertEqual(storedUser?.reposUrl, GitHubUser.mock().reposUrl)
        XCTAssertEqual(storedUser?.eventsUrl, GitHubUser.mock().eventsUrl)
        XCTAssertEqual(storedUser?.receivedEventsUrl, GitHubUser.mock().receivedEventsUrl)
        XCTAssertEqual(storedUser?.type, GitHubUser.mock().type)
        XCTAssertEqual(storedUser?.userViewType, GitHubUser.mock().userViewType)
        XCTAssertEqual(storedUser?.siteAdmin, GitHubUser.mock().siteAdmin)
    }
} 
