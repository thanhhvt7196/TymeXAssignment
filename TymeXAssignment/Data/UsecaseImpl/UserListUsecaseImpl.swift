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
    
    func getAllUsersFromCache() -> [GitHubUser] {
        return store.getAllUsers()
    }
    
    func cleanCache() {
        store.clean()
    }
    
    func saveCache(users: [GitHubUser]) {
        store.add(users: users)
    }
}
