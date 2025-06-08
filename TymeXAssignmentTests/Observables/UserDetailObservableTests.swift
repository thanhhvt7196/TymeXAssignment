import XCTest
@testable import TymeXAssignment

@MainActor
final class UserDetailObservableTests: XCTestCase {
    private var observable: UserDetailObservable!
    private var mockUseCase: MockUserDetailUseCase!
    private var mockUserService: MockUserService!
    private var mockAPIClient: MockAPIClient!
    private let testUsername = "mojombo"

    override func setUp() async throws {
        mockAPIClient = MockAPIClient()
        mockUserService = MockUserService(apiClient: mockAPIClient)
        mockUseCase = MockUserDetailUseCase(userService: mockUserService)
        observable = UserDetailObservable(usecase: mockUseCase, username: testUsername)
    }
    
    override func tearDown() async throws {
        mockAPIClient = nil
        mockUserService = nil
        mockUseCase = nil
        observable = nil
    }
    
    func test_init_shouldLoadUserDetail() async throws {
        let mockUser = GithubUserDetailDTO.mock()
        mockAPIClient.mockResult = .success(mockUser)
        await observable.getUserDetail()
        
        XCTAssertFalse(observable.isLoading)
        XCTAssertEqual(observable.userDetail?.id, mockUser.id?.value)
        XCTAssertEqual(observable.userDetail?.login, mockUser.login?.value)
    }
    
    func test_loadUserDetail_whenError_shouldUpdateErrorState() async {
        XCTAssertNil(observable.errorMessage)
        
        let mockAPIError = APIError.mock()
        mockAPIClient.mockResult = .failure(mockAPIError)
        
        await observable.getUserDetail()
        XCTAssertFalse(observable.isLoading)
        XCTAssertEqual(observable.errorMessage, mockAPIError.message)
        XCTAssertNil(observable.userDetail)
    }
} 
