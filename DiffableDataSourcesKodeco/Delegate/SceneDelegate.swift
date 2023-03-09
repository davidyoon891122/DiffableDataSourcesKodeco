//
//  SceneDelegate.swift
//  DiffableDataSourcesKodeco
//
//  Created by jiwon Yoon on 2023/03/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: VideosViewController())
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}

