//
//  UserServiceImpl.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

struct UserServiceImpl: UserService {
    private let apiClient: APIClient
    
    init(apiClient: APIClient = ServiceContainer.get()) {
        self.apiClient = apiClient
    }
    
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        return try await apiClient.request(router: .getGithubUsersList(itemPerPage: perPage, since: since), type: [GitHubUser].self)
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        return try await apiClient.request(router: .getUserDetails(username: username), type: GithubUserDetail.self)
    }
}
