//
//  UserFlowBuilder.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import SwiftData
import Foundation

class UserFlowBuilder {
    @MainActor static func buildUserList() -> UserListView {
        let store: UserStore = StoreContainer.get()
        let service: UserService = ServiceContainer.get()
        let useCase = UserListUsecaseImpl(store: store, service: service)
        return UserListView(usecase: useCase)
    }
    
    @MainActor static func buildUserDetail(username: String) -> UserDetailView {
        let service: UserService = ServiceContainer.get()
        let useCase = UserDetailUsecaseImpl(service: service)
        return UserDetailView(username: username, usecase: useCase)
        
    }
}
