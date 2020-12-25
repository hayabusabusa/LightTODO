//
//  SceneDelegate.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        configureRootViewController(windowScene: windowScene)
    }
}

extension SceneDelegate {
    
    private func configureRootViewController(windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIStoryboard(name: "TodosViewController", bundle: nil).instantiateInitialViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
