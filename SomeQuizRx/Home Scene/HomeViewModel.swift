//
//  HomeViewModel.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation

class HomeViewModel {
    private weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    
    init(coordinatorDelegate: HomeViewModelCoordinatorDelegate) {
           self.coordinatorDelegate = coordinatorDelegate
       }
}
extension HomeViewModel: HomeViewModelProtocol {
    
}
