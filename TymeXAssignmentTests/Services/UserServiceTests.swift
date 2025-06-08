import XCTest
@testable import TymeXAssignment

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
    
    func testFetchUsers_WhenAPISucceeds_ShouldReturnUsers() async throws {
        let mockUsers = GitHubUserDTO.mockList()
        mockAPIClient.mockResult = .success(mockUsers)
        
        let users = try await userService.fetchUsers(perPage: 20, since: 0)
        
        XCTAssertEqual(users.count, mockUsers.count)
        XCTAssertEqual(users.first?.id, 1)
        XCTAssertEqual(users.first?.login, "mojombo")
    }
    
    func testFetchUsers_WhenAPIFails_ShouldThrowError() async {
        let error = APIError(message: "User list API error")
        mockAPIClient.mockResult = .failure(error)
        
        do {
            try await userService.fetchUsers(perPage: 20, since: 0)
            XCTFail("Expected error to be thrown")
        } catch let thrownError as APIError {
            XCTAssertEqual(thrownError.message, "User list API error")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchUsers_ShouldUseCorrectRouter() async throws {
        mockAPIClient.mockResult = .success(GitHubUserDTO.mockList())
        
        try await userService.fetchUsers(perPage: 20, since: 20)
        
        if case .getGithubUsersList(let perPage, let since) = mockAPIClient.lastRouter {
            XCTAssertEqual(perPage, 20)
            XCTAssertEqual(since, 20)
        } else {
            XCTFail("Wrong router called")
        }
    }
    
    func testFetchUserDetail_WhenAPISucceeds_ShouldReturnUserDetail() async throws {
        let mockUserDetail = GithubUserDetailDTO.mock()
        mockAPIClient.mockResult = .success(mockUserDetail)
        
        let userDetail = try await userService.fetchUserDetail(username: "mojombo")
        
        XCTAssertEqual(userDetail.id, 1)
        XCTAssertEqual(userDetail.login, "mojombo")
        XCTAssertEqual(userDetail.name, "Tom Preston-Werner")
    }
    
    func testFetchUserDetail_WhenAPIFails_ShouldThrowError() async {
        let error = APIError(message: "User not found")
        mockAPIClient.mockResult = .failure(error)
        
        do {
            try await userService.fetchUserDetail(username: "fake username")
            XCTFail("Expected error to be thrown")
        } catch let thrownError as APIError {
            XCTAssertEqual(thrownError.message, "User not found")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchUserDetail_ShouldUseCorrectRouter() async throws {
        mockAPIClient.mockResult = .success(GithubUserDetailDTO.mock())
        
        try await userService.fetchUserDetail(username: "mojombo")
        
        if case .getUserDetails(let username) = mockAPIClient.lastRouter {
            XCTAssertEqual(username, "mojombo")
        } else {
            XCTFail("Wrong router called")
        }
    }
} 
