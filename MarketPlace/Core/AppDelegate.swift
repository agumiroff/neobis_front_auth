//
//  AppDelegate.swift
//  MarketPlace
//
//  Created by G G on 15.06.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        startApplication()
        
        return true
    }
    
    private func startApplication() {
        let navigation = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigation)
        coordinator?.start()
        window?.rootViewController = navigation
    }
}

