//
//  APIConstant.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

struct APIConstant {
    static let githubAPIURL = "https://api.github.com"
    
    struct APIPath {
        static let users = "/users"
    }
    
    struct APIParamKey {
        static let perPage = "per_page"
        static let since = "since"
    }
    
    struct APIHeaderKey {
        static let contentType = "Content-Type"
    }
    
    struct APIHeaderValue {
        static let applicationJson = "application/json;charset=utf-8"
    }
}
