import XCTest
@testable import TymeXAssignment

final class UserDetailUseCaseTests: XCTestCase {
    var mockUserService: MockUserService!
    var useCase: UserDetailUseCase!
    var mockAPIClient: MockAPIClient!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        mockUserService = MockUserService(apiClient: mockAPIClient)
        useCase = UserDetailUsecaseImpl(service: mockUserService)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        mockUserService = nil
        useCase = nil
        super.tearDown()
    }
    
    func testFetchUserDetail_ShouldReturnUserFromServer() async throws {
        let mockUser = GithubUserDetailDTO.mock()
        mockAPIClient.mockResult = .success(mockUser)
        
        let user = try await useCase.fetchUserDetail(username: "mojombo")
        
        XCTAssertEqual(user.id, mockUser.id?.value)
        XCTAssertEqual(user.login, mockUser.login?.value)
        XCTAssertEqual(user.name, mockUser.name?.value)
        XCTAssertEqual(user.location, mockUser.location?.value)
        XCTAssertEqual(user.publicRepos, mockUser.publicRepos?.value)
        XCTAssertEqual(user.followers, mockUser.followers?.value)
        XCTAssertEqual(user.following, mockUser.following?.value)
    }
    
    func testFetchUserDetail_WhenAPIFails_ShouldThrowError() async {
        let error = APIError(message: "User detail API error")
        mockAPIClient.mockResult = .failure(error)
        
        do {
            _ = try await useCase.fetchUserDetail(username: "fake username")
            XCTFail("Expected error to be thrown")
        } catch let thrownError as APIError {
            XCTAssertEqual(thrownError.message, "User detail API error")
        } catch {
            XCTFail("Unexpected error type: \(error)")
        }
    }
    
    func testFetchUsers_ShouldUseCorrectRouter() async throws {
        let mockUser = GithubUserDetailDTO.mock()
        mockAPIClient.mockResult = .success(mockUser)
        
        _ = try await useCase.fetchUserDetail(username: mockUser.login!.value!)
        
        if case .getUserDetails(let username) = mockAPIClient.lastRouter {
            XCTAssertEqual(username, mockUser.login!.value!)
        } else {
            XCTFail("Wrong router called")
        }
    }
}
