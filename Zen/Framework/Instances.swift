//
//  Instances.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class Instances {
    
    static let shared = Instances()
    
    let mainWindow = UIWindow()
    let rootNavigationController = UINavigationController()
    
    private init() {
        mainWindow.rootViewController = rootNavigationController
    }
    
}
