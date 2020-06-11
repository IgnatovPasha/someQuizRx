//
//  AppDelegate.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navController = UINavigationController()
        
        window = UIWindow()
        window?.rootViewController = navController
        
        coordinator = AppCoordinator(navigationController: navController, dismissHandler: nil)
        coordinator?.start()
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

