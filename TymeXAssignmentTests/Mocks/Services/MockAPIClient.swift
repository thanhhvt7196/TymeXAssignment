//
//  MockAPIClient.swift
//  TymeXAssignment
//
//  Created by thanh tien on 8/6/25.
//

import Foundation
@testable import TymeXAssignment

class MockAPIClient: APIClient {
    var mockResult: Result<Any, Error>?
    var lastRouter: APIRouter?
    
    func request<T>(router: APIRouter, type: T.Type) async throws -> T where T : Decodable {
        lastRouter = router
        
        guard let mockResult = mockResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch mockResult {
        case .success(let value):
            if let result = value as? T {
                return result
            } else {
                throw APIError(message: "Mock result type mismatch")
            }
        case .failure(let error):
            throw error
        }
    }
}
