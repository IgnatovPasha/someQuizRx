//
//  HomeCoordinator.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    var childCoordinators: [CoordinatorID : Coordinator]
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController, dismissHandler: (() -> ())?) {
        self.navigationController = navigationController
        childCoordinators = [:]
    }
    
    func start() {
        let homeVC = HomeViewController.instantiate()
        homeVC.viewModel = HomeViewModel(coordinatorDelegate: self)
        DispatchQueue.main.async {
            self.navigationController.pushViewController(homeVC, animated: true)
        }
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func showGameScene() {
        print("should showGameScene")
    }
    
    func showContactsScene() {
        print("should showContactsScene")
    }
    
    func showSettingsScene() {
        print("should showSettingsScene")
    }
    
    func showFAQScene() {
        print("should showFAQScene")
    }
    
  
    
}

