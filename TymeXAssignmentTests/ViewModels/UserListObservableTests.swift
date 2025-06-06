import XCTest
import SwiftData
@testable import TymeXAssignment

@MainActor
final class UserListObservableTests: XCTestCase {
    var mockService: MockUserService!
    var modelContainer: ModelContainer!
    var observable: UserListObservable!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
        
        let mockUsers = [
            GitHubUser(
                login: "user1",
                id: 1,
                nodeId: nil,
                avatarUrl: "https://example.com/1.jpg",
                gravatarId: nil,
                url: nil,
                htmlUrl: "https://github.com/user1",
                followersUrl: nil,
                followingUrl: nil,
                gistsUrl: nil,
                starredUrl: nil,
                subscriptionsUrl: nil,
                organizationsUrl: nil,
                reposUrl: nil,
                eventsUrl: nil,
                receivedEventsUrl: nil,
                type: "User",
                userViewType: nil,
                siteAdmin: false
            ),
            GitHubUser(
                login: "user2",
                id: 2,
                nodeId: nil,
                avatarUrl: "https://example.com/2.jpg",
                gravatarId: nil,
                url: nil,
                htmlUrl: "https://github.com/user2",
                followersUrl: nil,
                followingUrl: nil,
                gistsUrl: nil,
                starredUrl: nil,
                subscriptionsUrl: nil,
                organizationsUrl: nil,
                reposUrl: nil,
                eventsUrl: nil,
                receivedEventsUrl: nil,
                type: "User",
                userViewType: nil,
                siteAdmin: false
            )
        ]
        mockService.mockUsersResult = .success(mockUsers)
        
        do {
            let schema = Schema([GithubUserSwiftData.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            observable = UserListObservable(service: mockService, modelContainer: modelContainer)
        } catch {
            XCTFail("Failed to setup SwiftData container: \(error)")
        }
    }
    
    override func tearDown() {
        mockService = nil
        modelContainer = nil
        observable = nil
        super.tearDown()
    }
    
    func testLoadFirstPageSuccess() async throws {
        let mockUsers = [
            GitHubUser(
                login: "user1",
                id: 1,
                nodeId: nil,
                avatarUrl: "https://example.com/1.jpg",
                gravatarId: nil,
                url: nil,
                htmlUrl: "https://github.com/user1",
                followersUrl: nil,
                followingUrl: nil,
                gistsUrl: nil,
                starredUrl: nil,
                subscriptionsUrl: nil,
                organizationsUrl: nil,
                reposUrl: nil,
                eventsUrl: nil,
                receivedEventsUrl: nil,
                type: "User",
                userViewType: nil,
                siteAdmin: false
            ),
            GitHubUser(
                login: "user2",
                id: 2,
                nodeId: nil,
                avatarUrl: "https://example.com/2.jpg",
                gravatarId: nil,
                url: nil,
                htmlUrl: "https://github.com/user2",
                followersUrl: nil,
                followingUrl: nil,
                gistsUrl: nil,
                starredUrl: nil,
                subscriptionsUrl: nil,
                organizationsUrl: nil,
                reposUrl: nil,
                eventsUrl: nil,
                receivedEventsUrl: nil,
                type: "User",
                userViewType: nil,
                siteAdmin: false
            )
        ]
        mockService.mockUsersResult = .success(mockUsers)
        
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertEqual(observable.userList.count, 2)
        XCTAssertEqual(observable.userList[0].id, 1)
        XCTAssertEqual(observable.userList[0].login, "user1")
        XCTAssertEqual(observable.userList[1].id, 2)
        XCTAssertEqual(observable.userList[1].login, "user2")
        XCTAssertNil(observable.errorMessage)
        
        let descriptor = FetchDescriptor<GithubUserSwiftData>(sortBy: [SortDescriptor(\GithubUserSwiftData.id)])
        let cachedUsers = try modelContainer.mainContext.fetch(descriptor)
        XCTAssertEqual(cachedUsers.count, 2)
        XCTAssertEqual(cachedUsers[0].id, 1)
        XCTAssertEqual(cachedUsers[0].login, "user1")
    }
    
    func testLoadFirstPageError() async {
        let error = APIError(message: "Network error")
        mockService.mockUsersResult = .failure(error)
        
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertTrue(observable.userList.isEmpty)
        XCTAssertEqual(observable.errorMessage, "Network error")
    }
    
    func testLoadMoreSuccess() async throws {
        var initialUsers: [GitHubUser] = []
        for i in 1...2 {
            initialUsers.append(
                GitHubUser(
                    login: "user\(i)",
                    id: i,
                    nodeId: nil,
                    avatarUrl: "https://example.com/\(i).jpg",
                    gravatarId: nil,
                    url: nil,
                    htmlUrl: "https://github.com/user\(i)",
                    followersUrl: nil,
                    followingUrl: nil,
                    gistsUrl: nil,
                    starredUrl: nil,
                    subscriptionsUrl: nil,
                    organizationsUrl: nil,
                    reposUrl: nil,
                    eventsUrl: nil,
                    receivedEventsUrl: nil,
                    type: "User",
                    userViewType: nil,
                    siteAdmin: false
                )
            )
        }
        
        mockService.mockUsersResult = .success(initialUsers)
        await observable.loadFirstPage(needLoading: true)
        
        let moreUsers = [
            GitHubUser(
                login: "user3",
                id: 3,
                nodeId: nil,
                avatarUrl: "https://example.com/3.jpg",
                gravatarId: nil,
                url: nil,
                htmlUrl: "https://github.com/user3",
                followersUrl: nil,
                followingUrl: nil,
                gistsUrl: nil,
                starredUrl: nil,
                subscriptionsUrl: nil,
                organizationsUrl: nil,
                reposUrl: nil,
                eventsUrl: nil,
                receivedEventsUrl: nil,
                type: "User",
                userViewType: nil,
                siteAdmin: false
            )
        ]
        mockService.mockUsersResult = .success(moreUsers)
        
        await observable.loadMore()
        
        XCTAssertEqual(observable.userList.count, 3)
        XCTAssertEqual(observable.userList[0].id, 1)
        XCTAssertEqual(observable.userList[0].login, "user1")
        XCTAssertEqual(observable.userList[2].id, 3)
        XCTAssertEqual(observable.userList[2].login, "user3")
    }
    
    func testLoadCache() async throws {
        let user = GithubUserSwiftData(
            login: "user1",
            id: 1,
            nodeId: "test",
            avatarUrl: "https://example.com/1.jpg",
            htmlUrl: "https://github.com/user1"
        )
        modelContainer.mainContext.insert(user)
        try modelContainer.mainContext.save()
        
        observable = UserListObservable(service: mockService, modelContainer: modelContainer)
        
        XCTAssertEqual(observable.userList.count, 1)
        XCTAssertEqual(observable.userList[0].id, 1)
        XCTAssertEqual(observable.userList[0].login, "user1")
    }
} 