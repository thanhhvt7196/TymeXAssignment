//
//  UserListUsecase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

protocol UserListUsecase {
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser]
    func getAllUsersFromCache() -> [GitHubUser]
    func cleanCache()
    func saveCache(users: [GitHubUser])
}
