//
//  AppDelegate.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import UIKit
import SwiftData

class AppDelegate: UIResponder, UIApplicationDelegate {
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GithubUserSwiftData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
