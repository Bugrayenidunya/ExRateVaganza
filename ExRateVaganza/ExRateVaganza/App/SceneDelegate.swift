//
//  SceneDelegate.swift
//  ExRateVaganza
//
//  Created by Enes Buğra Yenidünya on 11.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: Properties
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let homeController = HomeBuilder.build()
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: homeController)
        window?.makeKeyAndVisible()
    }
}

