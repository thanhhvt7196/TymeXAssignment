import Foundation
@testable import TymeXAssignment

class MockAPIClient: APIClient {
    var mockResult: Result<Any, Error>?
    var delay: UInt64 = 0
    
    func request<T: Codable>(router: APIRouter, type: T.Type) async throws -> T {
        if delay > 0 {
            try await Task.sleep(nanoseconds: delay)
        }
        
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