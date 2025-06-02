//
//  APIRouter.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation
import Alamofire

// I don't wanna add Moya as dependency, so I make my own!
enum APIRouter: URLRequestConvertible {
    case getGithubUsersList(itemPerPage: Int, since: Int)
    case getUserDetails(username: String)
    
    var method: HTTPMethod {
        switch self {
        case .getGithubUsersList:
            return .get
        case .getUserDetails:
            return .get
        }
    }
    
    var baseURL: String {
        return APIConstant.githubAPIURL
    }
    
    var path: String {
        switch self {
        case .getGithubUsersList:
            return APIConstant.APIPath.users
        case .getUserDetails(let username):
            return APIConstant.APIPath.users + "/\(username)"
        }
    }
    
    private var parameters: Parameters? {
        return nil
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .getGithubUsersList(let itemPerPage, let since):
            return [
                .init(name: APIConstant.APIParamKey.perPage, value: itemPerPage.string),
                .init(name: APIConstant.APIParamKey.since, value: since.string)
            ]
        default:
            return nil
        }
    }
    
    private var headers: [String: String]? {
        return [APIConstant.APIHeaderKey.contentType: APIConstant.APIHeaderValue.applicationJson]
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlParameters = URLComponents(string: baseURL)
        urlParameters?.path = path
        urlParameters?.queryItems = queryItems
        
        guard let url = urlParameters?.url else {
            throw NSError(domain: "Not a valid URL", code: 0, userInfo: nil)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers?.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        if let parameters = parameters {
            switch self {
            default:
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: parameters)
                    urlRequest.httpBody = jsonData
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
        }
        return urlRequest
    }
}
