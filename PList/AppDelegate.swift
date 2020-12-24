//
//  AppDelegate.swift
//  PList
//
//  Created by Giuseppe Valenti on 17/12/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navVC = UINavigationController()
        coordinator = MainCoordinator(navigationController: navVC)
        coordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }


}

