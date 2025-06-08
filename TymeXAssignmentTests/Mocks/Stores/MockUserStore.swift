//
//  MockUserStore.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

class MockUserStore: UserStore {
    var mockStoredUsers: [GitHubUser] = []
    var lastSavedUsers: [GitHubUser]?
    
    func getAllUsers() -> [GitHubUser] {
        return mockStoredUsers
    }
    
    func clean() {
        mockStoredUsers.removeAll()
    }
    
    func add(users: [GitHubUser]) {
        lastSavedUsers = users
        mockStoredUsers.append(contentsOf: users)
    }
}
