import Foundation
@testable import TymeXAssignment

class MockUserService: UserService {
    var mockUserListResult: Result<[GitHubUser], Error>?
    var mockUserDetailResult: Result<GithubUserDetail, Error>?
    var lastFetchedUsername: String?
    var lastFetchedSince: Int?
    var lastFetchedPerPage: Int?
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        lastFetchedPerPage = perPage
        lastFetchedSince = since
        
        guard let mockResult = mockUserListResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch mockResult {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        lastFetchedUsername = username
        
        guard let mockResult = mockUserDetailResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch mockResult {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}
