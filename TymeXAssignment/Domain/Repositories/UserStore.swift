//
//  UserStore.swift
//  TymeXAssignment
//
//  Created by thanh tien on 4/6/25.
//

import Foundation

protocol UserStore {
    func getAllUsers() -> [GitHubUser]
    func clean()
    func add(users: [GitHubUser])
}
