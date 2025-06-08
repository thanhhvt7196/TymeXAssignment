//
//  MockUserListUseCase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

final class MockUserListUseCase: UserListUsecase {
    private let userService: MockUserService
    private let userStore: MockUserStore
    
    
    init(userService: MockUserService, userStore: MockUserStore) {
        self.userService = userService
        self.userStore = userStore
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        return try await userService.fetchUsers(perPage: perPage, since: since)
    }
    
    func getAllUsers() -> [GitHubUser] {
        return userStore.getAllUsers()
    }
    
    func clean() {
        return userStore.clean()
    }
    
    func add(users: [GitHubUser]) {
        return userStore.add(users: users)
    }
}
