//
//  UIWindow+Extensions.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import Foundation
import UIKit
import PulseUI

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        #if DEBUG
        if motion == .motionShake {
            let pulseInspectorVC = MainViewController()
            rootViewController?.present(pulseInspectorVC, animated: true)
        }
        #endif
    }
}
