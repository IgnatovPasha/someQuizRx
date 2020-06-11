//
//  AppCoordinator.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    enum ID {
        static let auth = "auth"
        static let home = "home"
    }
    
    var childCoordinators: [CoordinatorID : Coordinator]
    
    private let navigationController: UINavigationController!
    
    required init(navigationController: UINavigationController, dismissHandler: (() -> ())?) {
        self.navigationController = navigationController
        navigationController.isNavigationBarHidden = true
        childCoordinators = [:]
    }
    
    func start() {
        if Profile.shared.getToken() == nil {
            showAuthScene()
        } else {
            showHomeScene()
        }
    }
    
    func showAuthScene() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController, dismissHandler: nil)
        childCoordinators[ID.auth] = authCoordinator
        authCoordinator.start()
    }
    func showHomeScene() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController, dismissHandler: nil)
        childCoordinators[ID.home] = homeCoordinator
        homeCoordinator.start()
    }
    
    
}
