//
//  UIWindowExt.swift
//  RepairCheck
//
//  Created by thanh tien on 2/16/24.
//

import Foundation
import UIKit
import PulseUI

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let pulseInspectorVC = MainViewController()
            rootViewController?.present(pulseInspectorVC, animated: true)
        }
    }
}
