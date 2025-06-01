//
//  SceneDelegate.swift
//  Danger Repeller
//
//  Created by Никита Волков on 31.05.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let presenter = MainPresenter()
        let rootViewController = EnemiesViewController(presenter: presenter)
        presenter.enemyVC = rootViewController
        let navigationConttroller = UINavigationController(rootViewController: rootViewController)
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationConttroller
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

