//
//  StartCoordinator.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators: [CoordinatorID : Coordinator]
    let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController, dismissHandler: (() -> ())?) {
        self.navigationController = navigationController
        childCoordinators = [:]
    }
    
    func start() {
        showStartScene()
    }
    
    private enum ID {
        static let login = "login"
        static let registration = "registration"
    }
    
    private func showStartScene() {
        let startVC = AuthViewController.instantiate()
        startVC.viewModel = AuthViewModel(coordinatorDelegate: self)
        navigationController.pushViewController(startVC, animated: false)
    }
    
}

extension AuthCoordinator: AuthViewModelCoordinatorDelegate {
    func showLoginScene() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, dismissHandler: { [unowned self] in
            DispatchQueue.main.async {
                self.childCoordinators[ID.login] = nil
                self.navigationController.popViewController(animated: true)
            }
        })
        childCoordinators[ID.login] = loginCoordinator
        loginCoordinator.start()
    }
    
    func showRegistrationScene() {
        let registrationCoordinator = RegistrationCoordinator(navigationController: navigationController, dismissHandler: {
            DispatchQueue.main.async {
                self.childCoordinators[ID.registration] = nil
                self.navigationController.popViewController(animated: true)
            }
        })
        childCoordinators[ID.registration] = registrationCoordinator
        registrationCoordinator.start()
    }
}

