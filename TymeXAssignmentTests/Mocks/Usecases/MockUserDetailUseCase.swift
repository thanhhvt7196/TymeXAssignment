//
//  MockUserDetailUseCase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

class MockUserDetailUseCase: UserDetailUseCase {
    var mockResult: Result<GithubUserDetail, Error>?
    var lastUsername: String?
    var delay: UInt64 = 0
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        lastUsername = username
        
        if delay > 0 {
            try? await Task.sleep(nanoseconds: delay)
        }
        
        guard let mockResult = mockResult else {
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
