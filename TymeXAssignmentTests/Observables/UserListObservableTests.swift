import XCTest
@testable import TymeXAssignment

@MainActor
final class UserListObservableTests: XCTestCase {
    private var observable: UserListObservable!
    private var mockUseCase: MockUserListUseCase!
    private var mockUserService: MockUserService!
    private var mockUserStore: MockUserStore!
    private var mockAPIClient: MockAPIClient!
    
    override func setUp() async throws {
        mockAPIClient = MockAPIClient()
        mockUserStore = MockUserStore()
        mockUserService = MockUserService(apiClient: mockAPIClient)
        mockUseCase = MockUserListUseCase(userService: mockUserService, userStore: mockUserStore)
        observable = UserListObservable(usecase: mockUseCase)
    }
    
    override func tearDown() async throws {
        mockAPIClient = nil
        mockUserService = nil
        mockUserStore = nil
        mockUseCase = nil
        observable = nil
    }
    
    func test_init_loadAPIFirstTime() async throws {
        XCTAssertTrue(observable.userList.isEmpty)
        observable.loadCache()
        XCTAssertTrue(observable.userList.isEmpty)
        
        let mockUsers = GitHubUserDTO.mockList()
        mockAPIClient.mockResult = .success(mockUsers)
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertFalse(observable.isLoading)
        XCTAssertEqual(observable.userList.count, mockUsers.count)
        XCTAssertEqual(observable.userList.first?.id, mockUsers.first?.id?.value)
        
        let cachedData = mockUserStore.getAllUsers()
        XCTAssertEqual(cachedData.count, mockUsers.count)
        XCTAssertEqual(cachedData.first?.id, mockUsers.first?.id?.value)
        XCTAssertEqual(cachedData.first?.login, mockUsers.first?.login?.value)
    }
    
    func test_init_loadCacheThenRequestAPI() async throws {
        let mockCacheData = GitHubUser.mockList()
        mockUserStore.add(users: mockCacheData)
        XCTAssertTrue(observable.userList.isEmpty)
        observable.loadCache()
        XCTAssertEqual(observable.userList.count, mockCacheData.count)
        XCTAssertEqual(observable.userList.first?.id, mockCacheData.first?.id)
        XCTAssertEqual(observable.userList.first?.login, mockCacheData.first?.login)

        let mockUsers = GitHubUserDTO.mockList()
        mockAPIClient.mockResult = .success(mockUsers)
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertFalse(observable.isLoading)
        XCTAssertEqual(observable.userList.count, mockUsers.count)
        XCTAssertEqual(observable.userList.first?.id, mockUsers.first?.id?.value)
        
        let cachedData = mockUserStore.getAllUsers()
        XCTAssertEqual(cachedData.count, mockUsers.count)
        XCTAssertEqual(cachedData.first?.id, mockUsers.first?.id?.value)
        XCTAssertEqual(cachedData.first?.login, mockUsers.first?.login?.value)
    }
    
    func test_loadFirstPage_whenError_shouldUpdateErrorState() async {
        XCTAssertNil(observable.errorMessage)
        
        let mockAPIError = APIError.mock()
        mockAPIClient.mockResult = .failure(mockAPIError)
        
        await observable.loadFirstPage(needLoading: true)
        XCTAssertFalse(observable.isLoading)
        XCTAssertEqual(observable.errorMessage, mockAPIError.message)
        XCTAssertTrue(observable.userList.isEmpty)
    }
    
    func test_loadMore_whenSuccess_shouldAppendUsers() async {
        let mockUsers = [GitHubUserDTO.mock(), GitHubUserDTO.mock2()]
        mockAPIClient.mockResult = .success(mockUsers)
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertEqual(observable.userList.count, 2)
        
        mockAPIClient.mockResult = .success([GitHubUserDTO.mock3()])
        await observable.loadMore()
        
        XCTAssertEqual(observable.userList.count, 3)
    }
    
    func test_loadMore_whenDuplicateUsers_shouldNotAppend() async {
        let mockUsers = [GitHubUserDTO.mock(), GitHubUserDTO.mock2()]
        mockAPIClient.mockResult = .success(mockUsers)
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertEqual(observable.userList.count, 2)
        
        mockAPIClient.mockResult = .success([GitHubUserDTO.mock2()])
        await observable.loadMore()
        
        XCTAssertEqual(observable.userList.count, 2)
    }
    
    func test_loadMore_whenError_shouldNotUpdateState() async {
        let mockUsers = [GitHubUserDTO.mock(), GitHubUserDTO.mock2()]
        mockAPIClient.mockResult = .success(mockUsers)
        await observable.loadFirstPage(needLoading: true)
        
        XCTAssertEqual(observable.userList.count, 2)
        
        mockAPIClient.mockResult = .failure(APIError.mock())
        await observable.loadMore()
        
        XCTAssertEqual(observable.userList.count, 2)
        XCTAssertEqual(observable.errorMessage, nil)
    }
}
