//
//  LoginCoordinator.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    var childCoordinators: [CoordinatorID : Coordinator]
    
    private let navigationController: UINavigationController
    private let onDismiss: (()->())?
    private enum ID {
        static let home: CoordinatorID = "home"
    }
    
    required init(navigationController: UINavigationController, dismissHandler: (() -> ())?) {
        self.navigationController = navigationController
        self.onDismiss = dismissHandler
        childCoordinators = [:]
    }
    
    func start() {
        let loginVC = LoginViewController.instantiate()
        loginVC.viewModel = LoginViewModel(coordinatorDelegate: self)
        navigationController.pushViewController(loginVC, animated: true)
    }
}

extension LoginCoordinator: LoginViewModelCoordinatorDelegate {
    func back() {
        onDismiss?()
    }
    
    func login() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController,
                                              dismissHandler: { [unowned self] in
                                                DispatchQueue.main.async {
                                                    self.childCoordinators[ID.home] = nil
                                                    self.navigationController.popViewController(animated: true)
                                                }
        })
        childCoordinators[ID.home] = homeCoordinator
        homeCoordinator.start()
    }
}
