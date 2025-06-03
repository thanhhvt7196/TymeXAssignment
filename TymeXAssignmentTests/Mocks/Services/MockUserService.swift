import Foundation
@testable import TymeXAssignment

class MockUserService: UserService {
    var mockUsersResult: Result<[GitHubUser], Error>?
    var mockUserDetailResult: Result<GithubUserDetail, Error>?
    var delay: UInt64 = 0  // Delay in nanoseconds
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        if delay > 0 {
            try await Task.sleep(nanoseconds: delay)
        }
        
        guard let result = mockUsersResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch result {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        if delay > 0 {
            try await Task.sleep(nanoseconds: delay)
        }
        
        guard let result = mockUserDetailResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch result {
        case .success(let detail):
            return detail
        case .failure(let error):
            throw error
        }
    }
} 