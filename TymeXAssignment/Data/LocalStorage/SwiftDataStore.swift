//
//  RealmStore.swift
//  TymeXAssignmentUIKit
//
//  Created by thanh tien on 4/6/25.
//

import SwiftData
import Foundation

struct SwiftDataStore<T>: Storable where T: DomainConvertible, T.DomainType: SwiftDataRepresentable {
    typealias Model = T.DomainType.SwiftDataType
    
    let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func objects(_ conditions: Predicate<T.DomainType.SwiftDataType>?, sort usingDescriptors: [SortDescriptor<T.DomainType.SwiftDataType>]) -> [T.DomainType.SwiftDataType]? {
        let fetchDescriptor = FetchDescriptor(predicate: conditions, sortBy: usingDescriptors)
        let result = try? modelContext.fetch(fetchDescriptor)
        return result
    }
    
    func object(_ conditions: Predicate<T.DomainType.SwiftDataType>?, sort usingDescriptors: [SortDescriptor<T.DomainType.SwiftDataType>]) -> T.DomainType.SwiftDataType? {
        return objects(conditions, sort: usingDescriptors)?.first
    }
    
    func add(_ model: T.DomainType.SwiftDataType) {
        modelContext.insert(model)
        try? modelContext.save()
    }
    
    func delete(_ conditions: Predicate<T.DomainType.SwiftDataType>?, sort usingDescriptors: [SortDescriptor<T.DomainType.SwiftDataType>]) {
        guard let objects = objects(conditions, sort: usingDescriptors) else {
            return
        }
        objects.forEach { cache in
            modelContext.delete(cache)
        }
        try? modelContext.save()
    }
    
    func count(_ conditions: Predicate<T.DomainType.SwiftDataType>?) -> Int {
        let fetchDescriptor = FetchDescriptor(predicate: conditions)
        return (try? modelContext.fetchCount(fetchDescriptor)) ?? 0
    }
}
