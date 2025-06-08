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
    var errorMessage: String?

    @ObservationIgnored private let usecase: UserDetailUseCase
    @ObservationIgnored private let username: String
    
    init(usecase: UserDetailUseCase, username: String) {
        self.usecase = usecase
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
            let result = try await usecase.fetchUserDetail(username: username)
            userDetail = result
        } catch {
            errorMessage = (error as? APIError)?.message ?? error.localizedDescription
        }
    }
}
