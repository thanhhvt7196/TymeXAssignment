import XCTest
@testable import TymeXAssignment

final class UserListUseCaseTests: XCTestCase {
    var mockUserService: MockUserService!
    var mockUserStore: MockUserStore!
    var useCase: UserListUsecase!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        mockUserService = MockUserService(apiClient: mockAPIClient)
        mockUserStore = MockUserStore()
        useCase = UserListUsecaseImpl(store: mockUserStore, service: mockUserService)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        mockUserService = nil
        mockUserStore = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchUsers_ShouldReturnUsersFromServer() async throws {
        let mockUsers = GitHubUserDTO.mockList()
        mockAPIClient.mockResult = .success(mockUsers)
        
        let users = try await useCase.fetchUsers(perPage: 20, since: 0)
        
        XCTAssertEqual(users.count, mockUsers.count)
        XCTAssertEqual(users.first?.id, 1)
        XCTAssertEqual(users.first?.login, "mojombo")
    }
    
    func testGetAllUsers_ShouldReturnUsersFromStore() {
        let mockUsers = GitHubUser.mockList()
        mockUserStore.add(users: mockUsers)
        
        let users = useCase.getAllUsersFromCache()
        
        XCTAssertEqual(users.count, mockUsers.count)
        XCTAssertEqual(users.first?.id, mockUsers.first?.id)
        XCTAssertEqual(users.first?.login, mockUsers.first?.login)
    }
    
    func testFetchUsers_WhenAPIFails_ShouldThrowError() async {
        let error = APIError(message: "User list API error")
        mockAPIClient.mockResult = .failure(error)
        
        do {
            _ = try await useCase.fetchUsers(perPage: 20, since: 0)
            XCTFail("Expected error to be thrown")
        } catch let thrownError as APIError {
            XCTAssertEqual(thrownError.message, "User list API error")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchUsers_ShouldUseCorrectRouter() async throws {
        mockAPIClient.mockResult = .success(GitHubUserDTO.mockList())
        
        _ = try await useCase.fetchUsers(perPage: 20, since: 20)
        
        if case .getGithubUsersList(let perPage, let since) = mockAPIClient.lastRouter {
            XCTAssertEqual(perPage, 20)
            XCTAssertEqual(since, 20)
        } else {
            XCTFail("Wrong router called")
        }
    }
    
    func testClean_ShouldClearStore() {
        useCase.cleanCache()
        
        XCTAssertTrue(useCase.getAllUsersFromCache().isEmpty)
    }
} 
