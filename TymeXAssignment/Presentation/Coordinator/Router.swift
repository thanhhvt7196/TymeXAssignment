//
//  Router.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI
import Observation

enum RouterPath: Hashable {
    case userList
    case userDetail(GitHubUser)
}

@Observable
final class Router {
    var path = NavigationPath()
}
