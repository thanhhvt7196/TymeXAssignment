//
//  StoreContainer.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Swinject
import SwiftData

struct StoreContainer: DIContainer {
    static var container: Container {
        let container = Container()
        
        container.register(ModelContainer.self) { _ in
            AppDelegate.sharedModelContainer
        }
        .inObjectScope(.container)
        
        container.register(UserStore.self) { _ in
            guard let modelContainer = container.resolve(ModelContainer.self) else {
                fatalError("Failed to resolve ModelContainer")
            }
            return UserStoreImpl(collection: SwiftDataStore<GithubUserSwiftData>(modelContext: ModelContext(modelContainer)))
        }
        .inObjectScope(.container)
        
        return container
    }
}
