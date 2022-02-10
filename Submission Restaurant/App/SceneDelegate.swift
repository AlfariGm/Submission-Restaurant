//
//  SceneDelegate.swift
//  Submission Restaurant
//
//  Created by Galfari on 11/11/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let homeUseCase = Injection.init().proviceHome()
        let favoriteUseCase = Injection.init().provideFavRestaurant()
        
        let homePresenter = HomePresenter(homeUseCase: homeUseCase)
        let favoritePresenter = FavoritePresenter(favoriteUseCase: favoriteUseCase)
        
        let contentView = AppCoordinator()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

