//
//  SceneDelegate.swift
//  AppStoreSearch
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let vc0 = ViewController()
        vc0.title = "투데이"
        vc0.tabBarItem = .init(title: "투데이", image: UIImage(systemName: "doc.text.image"), tag: 1)
        
        let vc1 = ViewController()
        vc1.title = "게임"
        vc1.tabBarItem = .init(title: "게임", image: UIImage(systemName: "flag.filled.and.flag.crossed"), tag: 1)
        
        let vc2 = ViewController()
        vc2.title = "앱"
        vc2.tabBarItem = .init(title: "앱", image: UIImage(systemName: "square.stack.3d.up.fill"), tag: 1)
        
        let vc3 = ViewController()
        vc3.title = "Arcade"
        vc3.tabBarItem = .init(title: "Arcade", image: UIImage(systemName: "gamecontroller.fill"), tag: 1)
        
        let searchViewController = ViewController()
        searchViewController.title = "검색"
        searchViewController.tabBarItem = .init(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            vc0.withNavigatioanController,
            vc1.withNavigatioanController,
            vc2.withNavigatioanController,
            vc3.withNavigatioanController,
            searchViewController.withNavigatioanController
        ]
        
        tabBarController.selectedIndex = 4
        
        window?.rootViewController = tabBarController
        
        window?.makeKeyAndVisible()
        
    }
}

