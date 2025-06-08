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
    
    func getAllUsersFromCache() -> [GitHubUser] {
        return userStore.getAllUsers()
    }
    
    func cleanCache() {
        return userStore.clean()
    }
    
    func saveCache(users: [GitHubUser]) {
        return userStore.add(users: users)
    }
}
