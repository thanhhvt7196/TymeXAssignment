//
//  UserListUsecase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

protocol UserListUsecase {
    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser]
    func getAllUsers() -> [GitHubUser]
    func clean()
    func add(users: [GitHubUser])
}
