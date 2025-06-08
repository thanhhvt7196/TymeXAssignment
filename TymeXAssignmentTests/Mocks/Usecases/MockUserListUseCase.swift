//
//  MockUserListUseCase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

class MockUserListUseCase: UserListUsecase {
    var mockResult: Result<[GitHubUser], Error>?
    var lastPerPage: Int?
    var lastSince: Int?
    var delay: UInt64 = 0
    var mockStoredUsers: [GitHubUser] = []
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        lastPerPage = perPage
        lastSince = since
        
        if delay > 0 {
            try? await Task.sleep(nanoseconds: delay)
        }
        
        guard let mockResult = mockResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch mockResult {
        case .success(let users):
            return users
        case .failure(let error):
            throw error
        }
    }
    
    func getAllUsers() -> [GitHubUser] {
        return mockStoredUsers
    }
    
    func clean() {
        mockStoredUsers.removeAll()
    }
    
    func add(users: [GitHubUser]) {
        mockStoredUsers.append(contentsOf: users)
    }
}
