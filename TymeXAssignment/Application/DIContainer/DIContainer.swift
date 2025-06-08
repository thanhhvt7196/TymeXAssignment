//
//  DIContainer.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Swinject

protocol DIContainer {
    static var container: Container { get }
    static func send<T>(_ value: T, withKey key: String)
    static func get<T>(key: String?) -> T
    static func get<T, P>(arg: P, key: String?) -> T
}

extension DIContainer {
    static func send<T>(_ value: T, withKey key: String) {
        container.register(T.self, name: key) { _ -> T in
            return value
        }
    }
    
    static func get<T>(key: String? = nil) -> T {
        guard let t = container.resolve(T.self, name: key) else {
            fatalError("Could not resolve dependency for key: \(key ?? "unknown")")
        }
        return t
    }
    
    static func get<T, P>(arg: P, key: String?) -> T {
        guard let t = container.resolve(T.self, name: key, argument: arg) else {
            fatalError("Could not resolve dependency for key: \(key ?? "unknown")")
        }
        return t
    }
}
