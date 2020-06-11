//
//  StartViewModel.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation
import RxRelay

class AuthViewModel: AuthViewModelProtocol {
    let appName = BehaviorRelay<String>(value: "Quiz")
    let motto = BehaviorRelay<String>(value: "Listen. Choose. Win!")
    let loginOptionTitle = BehaviorRelay<String>(value: NSLocalizedString("Login", comment: "Login call to action title"))
    let registrationOptionTitle = BehaviorRelay<String>(value: NSLocalizedString("Register", comment: "Registration call to action title"))
    
    private weak var coordinatorDelegate: AuthViewModelCoordinatorDelegate?
    
    init(coordinatorDelegate: AuthViewModelCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
    }
    
    public func login() {
        coordinatorDelegate?.showLoginScene()
    }
    
    public func register() {
        coordinatorDelegate?.showRegistrationScene()
    }
}

