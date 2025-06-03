import Foundation
@testable import TymeXAssignment

class MockAPIClient: APIClient {
    var mockResult: Result<Any, Error>?
    
    func request<T: Codable>(router: APIRouter, type: T.Type) async throws -> T {
        guard let mockResult = mockResult else {
            throw APIError(message: "No mock result set")
        }
        
        switch mockResult {
        case .success(let data):
            if let result = data as? T {
                return result
            } else {
                throw APIError(message: "Mock data type mismatch")
            }
        case .failure(let error):
            throw error
        }
    }
} 