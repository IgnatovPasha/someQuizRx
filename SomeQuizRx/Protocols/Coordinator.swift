//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Pavel on 12.01.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

typealias CoordinatorID = String

protocol Coordinator: AnyObject {
    var childCoordinators: [CoordinatorID: Coordinator] {get set}
    init(navigationController: UINavigationController, dismissHandler: (()->())?)

    func start()
}
protocol CoordinatorDelegate: AnyObject {
    
}
