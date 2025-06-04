//
//  TymeXAssignmentApp.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI

@main
struct TymeXAssignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @State private var router = Router()

    var body: some Scene {
        WindowGroup {
            UserListView()
                .preferredColorScheme(.light)
                .environment(router)
        }
    }
}
