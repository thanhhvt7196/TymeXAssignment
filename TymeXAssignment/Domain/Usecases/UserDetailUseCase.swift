//
//  UserDetailUseCase.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

protocol UserDetailUseCase {
    func fetchUserDetail(username: String) async throws -> GithubUserDetail
}
