//
//  Storable.swift
//  TymeXAssignment
//
//  Created by thanh tien on 4/6/25.
//



import Foundation
import SwiftData

protocol Storable {
    associatedtype Model: PersistentModel
    
    func objects(_ conditions: Predicate<Model>?, sort usingDescriptors: [SortDescriptor<Model>]) -> [Model]?
    func object(_ conditions: Predicate<Model>?, sort usingDescriptors: [SortDescriptor<Model>]) -> Model?
    func add(_ model: Model)
    func delete(_ conditions: Predicate<Model>?, sort usingDescriptors: [SortDescriptor<Model>])
    func count(_ conditions: Predicate<Model>?) -> Int
}
