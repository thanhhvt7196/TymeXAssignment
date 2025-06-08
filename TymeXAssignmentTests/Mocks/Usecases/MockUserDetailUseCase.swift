//
//  MockUserDetailUseCase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

final class MockUserDetailUseCase: UserDetailUseCase {
    private let userService: MockUserService
    
    init(userService: MockUserService) {
        self.userService = userService
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        return try await userService.fetchUserDetail(username: username)
    }
}
