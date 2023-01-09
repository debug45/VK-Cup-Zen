//
//  SceneDelegate.swift
//  Zen
//
//  Created by Sergey Moskvin on 09.01.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let mainWindow = Instances.shared.mainWindow
        mainWindow.windowScene = scene as? UIWindowScene
        
        Instances.shared.rootNavigationController.setViewControllers([
            MainViewController()
        ], animated: false)
        
        mainWindow.makeKeyAndVisible()
    }
    
}
