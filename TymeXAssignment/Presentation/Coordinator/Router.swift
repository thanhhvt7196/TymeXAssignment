//
//  Router.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI

enum RouterPath {
    case userList
    case userDetail(GitHubUser)
}

final class Router: ObservableObject {
    @Published var path = NavigationPath()
}
