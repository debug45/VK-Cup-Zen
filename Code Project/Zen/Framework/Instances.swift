//
//  Instances.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class Instances {
    
    static let mainWindow = UIWindow {
        $0.rootViewController = rootNavigationController
    }
    
    static let rootNavigationController = UINavigationController()
    
    static let percentFormatter = NumberFormatter {
        $0.maximumFractionDigits = 0
        $0.numberStyle = .percent
    }
    
}
