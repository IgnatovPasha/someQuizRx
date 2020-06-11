//
//  StartViewModelCoordinatorDelegate.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation

protocol AuthViewModelCoordinatorDelegate: AnyObject {
    func showLoginScene()
    func showRegistrationScene()
}
