//
//  UserListUsecaseImpl.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//


struct UserListUsecaseImpl: UserListUsecase {
    private let store: UserStore
    private let service: UserService
    
    init(store: UserStore, service: UserService) {
        self.store = store
        self.service = service
    }

    func fetchUsers(perPage: Int, since: Int) async throws -> [GitHubUser] {
        return try await service.fetchUsers(perPage: perPage, since: since)
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        return try await service.fetchUserDetail(username: username)
    }
    
    func getAllUsers() -> [GitHubUser] {
        return store.getAllUsers()
    }
    
    func clean() {
        store.clean()
    }
    
    func add(users: [GitHubUser]) {
        store.add(users: users)
    }
}
