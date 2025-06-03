import XCTest
@testable import TymeXAssignment

@MainActor
final class UserDetailObservableTests: XCTestCase {
    var mockService: MockUserService!
    var observable: UserDetailObservable!
    
    override func setUp() {
        super.setUp()
        mockService = MockUserService()
    }
    
    override func tearDown() {
        mockService = nil
        observable = nil
        super.tearDown()
    }
    
    func testFetchUserDetailSuccess() async throws {
        let mockUserDetail = GithubUserDetail(
            id: 1,
            login: "octocat",
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://github.com/images/error/octocat_happy.gif",
            gravatarId: nil,
            url: nil,
            htmlUrl: "https://github.com/octocat",
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
            siteAdmin: false,
            name: "monalisa octocat",
            company: "GitHub",
            blog: "https://github.com/blog",
            location: "San Francisco",
            email: "octocat@github.com",
            hireable: false,
            bio: "There once was...",
            twitterUsername: "monatheoctocat",
            publicRepos: 2,
            publicGists: 1,
            followers: 20,
            following: 0,
            createdAt: "2008-01-14T04:33:35Z",
            updatedAt: "2008-01-14T04:33:35Z"
        )
        mockService.mockUserDetailResult = .success(mockUserDetail)
        
        observable = UserDetailObservable(service: mockService, username: "octocat")
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertNotNil(observable.userDetail)
        XCTAssertEqual(observable.userDetail?.id, 1)
        XCTAssertEqual(observable.userDetail?.login, "octocat")
        XCTAssertEqual(observable.userDetail?.name, "monalisa octocat")
        XCTAssertEqual(observable.userDetail?.company, "GitHub")
        XCTAssertEqual(observable.userDetail?.location, "San Francisco")
        XCTAssertEqual(observable.userDetail?.followers, 20)
        XCTAssertEqual(observable.userDetail?.following, 0)
        XCTAssertNil(observable.errorMessage)
        XCTAssertFalse(observable.isLoading)
    }
    
    func testFetchUserDetailError() async throws {
        let error = APIError(message: "User not found")
        mockService.mockUserDetailResult = .failure(error)
        
        observable = UserDetailObservable(service: mockService, username: "nonexistent")
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertNil(observable.userDetail)
        XCTAssertEqual(observable.errorMessage, "User not found")
        XCTAssertFalse(observable.isLoading)
    }
    
    func testLoadingState() async throws {
        let mockUserDetail = GithubUserDetail(
            id: 1,
            login: "octocat",
            nodeId: "MDQ6VXNlcjE=",
            avatarUrl: "https://github.com/images/error/octocat_happy.gif",
            gravatarId: nil,
            url: nil,
            htmlUrl: "https://github.com/octocat",
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
            siteAdmin: false,
            name: "monalisa octocat",
            company: "GitHub",
            blog: "https://github.com/blog",
            location: "San Francisco",
            email: "octocat@github.com",
            hireable: false,
            bio: "There once was...",
            twitterUsername: "monatheoctocat",
            publicRepos: 2,
            publicGists: 1,
            followers: 20,
            following: 0,
            createdAt: "2008-01-14T04:33:35Z",
            updatedAt: "2008-01-14T04:33:35Z"
        )
        
        mockService.delay = 50_000_000
        mockService.mockUserDetailResult = .success(mockUserDetail)
        
        observable = UserDetailObservable(service: mockService, username: "octocat")
        
        try await Task.sleep(nanoseconds: 10_000_000)
        
        XCTAssertTrue(observable.isLoading)
        
        try await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertFalse(observable.isLoading)
        XCTAssertNotNil(observable.userDetail)
        XCTAssertNil(observable.errorMessage)
    }
} 