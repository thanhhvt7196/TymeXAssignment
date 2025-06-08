//
//  DataType.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation

public enum DataType<T: Codable>: Codable {
    case value(T)
    case null
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        guard !container.decodeNil() else {
            self = .null
            return
        }
        let value = try container.decode(T.self)
        self = .value(value)
    }
    
    public init(_ value: T?) {
        self = value.map(DataType.value) ?? .null
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case let .value(value):
            try container.encode(value)
        case .null:
            try container.encodeNil()
        }
    }
    
    var value: T? {
        if case let .value(v) = self {
            return v
        }
        return nil
    }
}
