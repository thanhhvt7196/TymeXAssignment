//
//  SwiftDataRepresentable.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftData
import Foundation

protocol SwiftDataRepresentable {
    associatedtype SwiftDataType: PersistentModel
    
    func toSwiftData() -> SwiftDataType
}

protocol DomainConvertible {
    associatedtype DomainType
    
    func toDomain() -> DomainType
}
