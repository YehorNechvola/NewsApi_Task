//
//  SceneDelegate.swift
//  NewsApi_Task
//
//  Created by Rush_user on 09.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.mainCoordinator = mainCoordinator
        mainCoordinator.start()
    }
}

