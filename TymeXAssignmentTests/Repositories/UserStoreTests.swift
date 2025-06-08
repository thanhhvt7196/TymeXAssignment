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
    
    func testAddUsers_ShouldSaveToStore() async throws {
        let users = [
            GitHubUser(login: "user1", id: 1, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil),
            GitHubUser(login: "user2", id: 2, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil)
        ]
        
        userStore.add(users: users)
        
        let storedUsers = userStore.getAllUsers()
        XCTAssertEqual(storedUsers.count, 2)
        XCTAssertEqual(storedUsers[0].login, "user1")
        XCTAssertEqual(storedUsers[0].id, 1)
        XCTAssertEqual(storedUsers[1].login, "user2")
        XCTAssertEqual(storedUsers[1].id, 2)
    }
    
    func testGetAllUsers_WhenEmpty_ShouldReturnEmptyArray() async throws {
        let users = userStore.getAllUsers()
        
        XCTAssertTrue(users.isEmpty)
    }
    
    func testGetAllUsers_ShouldReturnSortedById() async throws {
        let users = [
            GitHubUser(login: "user3", id: 3, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil),
            GitHubUser(login: "user1", id: 1, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil),
            GitHubUser(login: "user2", id: 2, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil)
        ]
        userStore.add(users: users)
        
        let storedUsers = userStore.getAllUsers()
        
        XCTAssertEqual(storedUsers.count, 3)
        XCTAssertEqual(storedUsers[0].id, 1)
        XCTAssertEqual(storedUsers[0].login, "user1")
        XCTAssertEqual(storedUsers[1].id, 2)
        XCTAssertEqual(storedUsers[1].login, "user2")
        XCTAssertEqual(storedUsers[2].id, 3)
        XCTAssertEqual(storedUsers[2].login, "user3")
    }
    
    func testClean_ShouldRemoveAllUsers() async throws {
        let users = [
            GitHubUser(login: "user1", id: 1, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil),
            GitHubUser(login: "user2", id: 2, nodeId: nil, avatarUrl: nil, gravatarId: nil, url: nil, htmlUrl: nil, followersUrl: nil, followingUrl: nil, gistsUrl: nil, starredUrl: nil, subscriptionsUrl: nil, organizationsUrl: nil, reposUrl: nil, eventsUrl: nil, receivedEventsUrl: nil, type: nil, userViewType: nil, siteAdmin: nil)
        ]
        userStore.add(users: users)
        XCTAssertEqual(userStore.getAllUsers().count, 2)
        
        userStore.clean()
        XCTAssertTrue(userStore.getAllUsers().isEmpty)
    }
    
    func testAddUsers_WithAllFields_ShouldPreserveData() async throws {
        let user = GitHubUser(
            login: "mojombo",
            id: 1,
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4",
            gravatarId: nil,
            url: "https://api.github.com/users/mojombo",
            htmlUrl: "https://github.com/mojombo",
            followersUrl: "https://api.github.com/users/mojombo/followers",
            followingUrl: "https://api.github.com/users/mojombo/following{/other_user}",
            gistsUrl: "https://api.github.com/users/mojombo/gists{/gist_id}",
            starredUrl: "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
            subscriptionsUrl: "https://api.github.com/users/mojombo/subscriptions",
            organizationsUrl: "https://api.github.com/users/mojombo/orgs",
            reposUrl: "https://api.github.com/users/mojombo/repos",
            eventsUrl: "https://api.github.com/users/mojombo/events{/privacy}",
            receivedEventsUrl: "https://api.github.com/users/mojombo/received_events",
            type: "User",
            userViewType: "public",
            siteAdmin: true
        )
        
        userStore.add(users: [user])
        
        let storedUser = userStore.getAllUsers().first
        XCTAssertNotNil(storedUser)
        XCTAssertEqual(storedUser?.login, "mojombo")
        XCTAssertEqual(storedUser?.id, 1)
        XCTAssertEqual(storedUser?.nodeId, "MDQ6VXNlcjE=")
        XCTAssertEqual(storedUser?.avatarUrl, "https://avatars.githubusercontent.com/u/1?v=4")
        XCTAssertEqual(storedUser?.gravatarId, nil)
        XCTAssertEqual(storedUser?.url, "https://api.github.com/users/mojombo")
        XCTAssertEqual(storedUser?.htmlUrl, "https://github.com/mojombo")
        XCTAssertEqual(storedUser?.followersUrl, "https://api.github.com/users/mojombo/followers")
        XCTAssertEqual(storedUser?.followingUrl, "https://api.github.com/users/mojombo/following{/other_user}")
        XCTAssertEqual(storedUser?.gistsUrl, "https://api.github.com/users/mojombo/gists{/gist_id}")
        XCTAssertEqual(storedUser?.starredUrl, "https://api.github.com/users/mojombo/starred{/owner}{/repo}")
        XCTAssertEqual(storedUser?.subscriptionsUrl, "https://api.github.com/users/mojombo/subscriptions")
        XCTAssertEqual(storedUser?.organizationsUrl, "https://api.github.com/users/mojombo/orgs")
        XCTAssertEqual(storedUser?.reposUrl, "https://api.github.com/users/mojombo/repos")
        XCTAssertEqual(storedUser?.eventsUrl, "https://api.github.com/users/mojombo/events{/privacy}")
        XCTAssertEqual(storedUser?.receivedEventsUrl, "https://api.github.com/users/mojombo/received_events")
        XCTAssertEqual(storedUser?.type, "User")
        XCTAssertEqual(storedUser?.userViewType, "public")
        XCTAssertEqual(storedUser?.siteAdmin, true)
    }
} 
