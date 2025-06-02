//
//  UserServiceImpl.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

struct UserServiceImpl: UserService {
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        let service: UserService = ServiceContainer.get()
        return try await service.fetchUsers(perPage: perPage, since: since)
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        let service: UserService = ServiceContainer.get()
        return try await service.fetchUserDetail(username: username)
    }
}
