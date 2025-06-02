//
//  ServiceContainer.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Swinject

struct ServiceContainer: DIContainer {
    static var container: Container {
        let container = Container()
        
        container.register(UserService.self) { _ in
            UserServiceImpl()
        }
        .inObjectScope(.container)
        
        return container
    }
}
