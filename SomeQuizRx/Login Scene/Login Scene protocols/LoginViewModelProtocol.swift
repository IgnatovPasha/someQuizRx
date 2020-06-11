//
//  LoginViewModelProtocol.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

protocol LoginViewModelProtocol: AnyObject {
    var title:  BehaviorRelay<String> {get}
    
    var emailPlaceholder: String {get}
    var passwordPlaceholder: String {get}
    var recoveryTitle: BehaviorRelay<String> {get}
    var passwordRecoveryAttempt: PublishRelay<Void> {get}
    
    var email: BehaviorRelay<String> {get}
    var password: BehaviorRelay<String> {get}
    var isLoginEnabled: Observable<Bool> {get}
    var alert: PublishRelay<AlertViewModel> {get}
        
    var loginAttempt: PublishRelay<Void> {get}
    var dismiss: PublishRelay<Void> {get}
}
