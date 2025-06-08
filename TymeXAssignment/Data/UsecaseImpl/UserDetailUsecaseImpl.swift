//
//  UserDetailUsecaseImpl.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//


struct UserDetailUsecaseImpl: UserDetailUseCase {
    private let service: UserService
    
    init(service: UserService) {
        self.service = service
    }
    
    func fetchUserDetail(username: String) async throws -> GithubUserDetail {
        return try await service.fetchUserDetail(username: username)
    }
}
