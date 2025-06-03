//
//  UserDetailObservable.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import Observation

@MainActor
@Observable
final class UserDetailObservable {
    var userDetail: GithubUserDetail?
    var isLoading = false
    var error: Error?
    
    private let service: UserService
    private let username: String
    
    init(service: UserService, username: String) {
        self.service = service
        self.username = username
        Task {
            await getUserDetail()
        }
    }
    
    private func getUserDetail() async {
        defer {
            isLoading = false
        }
        isLoading = true
        do {
            let result = try await service.fetchUserDetail(username: username)
            userDetail = result
        } catch {
            self.error = error
        }
    }
}
