//
//  APIError.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation

struct APIError: Error, Codable {
    var message: String?
    var documentationUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case documentationUrl = "documentation_url"
    }
}
