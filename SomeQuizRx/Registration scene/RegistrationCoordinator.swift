//
//  RegistrationCoordinator.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class RegistrationCoordinator: Coordinator {
    var childCoordinators: [CoordinatorID : Coordinator]
    
    private let navigationController: UINavigationController
    private let onDismiss: (()->())?
    private enum ID {
//        static let home: CoordinatorID = "home"
    }
    
    required init(navigationController: UINavigationController, dismissHandler: (() -> ())?) {
        self.navigationController = navigationController
        self.onDismiss = dismissHandler
        childCoordinators = [:]
    }
    
    func start() {
        let registrationVC = RegistrationViewController.instantiate()
        registrationVC.viewModel = RegistrationViewModel(coordinatorDelegate: self)
        navigationController.pushViewController(registrationVC, animated: true)
    }
}

extension RegistrationCoordinator: RegistrationViewModelCoordinatorDelegate {
    func back() {
        onDismiss?()
    }
    
    func register() {
        print("request for registration")
    }
}
