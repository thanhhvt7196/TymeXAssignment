//
//  UserStoreImpl.swift
//  TymeXAssignment
//
//  Created by thanh tien on 4/6/25.
//

import Foundation
import SwiftData

struct UserStoreImpl<C: Storable>: UserStore where C.Model == GithubUserSwiftData {
    private let collection: C
    
    init(collection: C) {
        self.collection = collection
    }
    
    func getAllUsers() -> [GitHubUser] {
        let cacheData = collection.objects(nil, sort: [SortDescriptor(\.id)]) ?? []
        return cacheData.map { $0.toDomain() }
    }
    
    func clean() {
        collection.delete(nil, sort: [])
    }
    
    func add(users: [GitHubUser]) {
        users.forEach { user in
            collection.add(user.toSwiftData())
        }
    }
}
