//
//  UserService.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

protocol UserService {
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser]
    func fetchUserDetail(username: String) async throws -> GithubUserDetail
}
