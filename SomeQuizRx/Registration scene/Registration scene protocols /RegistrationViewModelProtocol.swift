//
//  RegistrationViewModelProtocol.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

protocol RegistrationViewModelProtocol: AnyObject {
    
    var title: BehaviorRelay<String> {get}
    
    var namePlaceholder: String {get}
    var emailPlaceholder: String {get}
    var passwordPlaceholder: String {get}
    var confirmPasswordPlaceholder: String {get}
    
    var name: BehaviorRelay<String> {get}
    var email: BehaviorRelay<String> {get}
    var password: BehaviorRelay<String> {get}
    var confirmPassword: BehaviorRelay<String> {get}
    
    var resolvedEmail: Observable<String> {get}
    var isValidName: Observable<Bool> {get}
    var isValidEmail: Observable<Bool> {get}
    var isValidPassword: Observable<Bool> {get}
    
    var isRegistrationEnabled: Observable<Bool> {get}
    var alert: PublishRelay<AlertViewModel> {get}
        
    var registrationAttempt: PublishRelay<Void> {get}
    var dismiss: PublishRelay<Void> {get}
    
}
