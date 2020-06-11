//
//  StartViewModelProtocol.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation
import RxRelay

protocol AuthViewModelProtocol: AnyObject {
    
    var appName:  BehaviorRelay<String> {get}
    var motto:  BehaviorRelay<String> {get}
    var loginOptionTitle:  BehaviorRelay<String> {get}
    var registrationOptionTitle:  BehaviorRelay<String> {get}
    
    
    
    func login()
    func register()
}
