import XCTest
@testable import TymeXAssignment

@MainActor
final class UserServiceTests: XCTestCase {
    var mockAPIClient: MockAPIClient!
    var userService: UserServiceImpl!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        userService = UserServiceImpl(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        userService = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() async throws {
        // Given
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
        
        mockAPIClient.mockResult = .success(mockUsers)
        
        // When
        let users = try await userService.fetchUsers(perPage: 20, since: 0)
        
        // Then
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].id, 1)
        XCTAssertEqual(users[0].login, "user1")
        XCTAssertEqual(users[1].id, 2)
        XCTAssertEqual(users[1].login, "user2")
    }
    
    func testFetchUsersError() async {
        // Given
        let error = APIError(message: "Network error")
        mockAPIClient.mockResult = .failure(error)
        
        // When/Then
        do {
            _ = try await userService.fetchUsers(perPage: 20, since: 0)
            XCTFail("Expected to throw an error")
        } catch let thrownError as APIError {
            XCTAssertEqual(thrownError.message, "Network error")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchUserDetailSuccess() async throws {
        // Given
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
        
        mockAPIClient.mockResult = .success(mockUserDetail)
        
        // When
        let userDetail = try await userService.fetchUserDetail(username: "octocat")
        
        // Then
        XCTAssertEqual(userDetail.id, 1)
        XCTAssertEqual(userDetail.login, "octocat")
        XCTAssertEqual(userDetail.name, "monalisa octocat")
        XCTAssertEqual(userDetail.company, "GitHub")
        XCTAssertEqual(userDetail.blog, "https://github.com/blog")
    }
} 
