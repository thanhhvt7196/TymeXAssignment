//
//  AppDelegate.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import UIKit
import SwiftData
import Pulse
import PulseUI
import PulseProxy

class AppDelegate: UIResponder, UIApplicationDelegate {    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupPulse()
        return true
    }
    
    private func setupPulse() {
        NetworkLogger.enableProxy()
    }
}
