//
//  LoginViewModel.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation
import RxRelay
import RxSwift

enum LoginError: LocalizedError {
    case notValidatedCredentials
    
    var errorDescription: String? {
        switch self {
        case .notValidatedCredentials: return "Both valid email and password required to proceed"
        }
    }
}

class LoginViewModel: LoginViewModelProtocol {
    let title = BehaviorRelay<String>(value: NSLocalizedString("Login", comment: "Login scene title"))
    
    let emailPlaceholder: String = NSLocalizedString("E-mail", comment: "textfield placeholder")
    let passwordPlaceholder: String = NSLocalizedString("Password", comment: "textfield placeholder")
    
    let recoveryTitle = BehaviorRelay<String>(value: NSLocalizedString("Forgot password?", comment: "title for password recovery option"))
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isLoginEnabled: Observable<Bool>
    let alert = PublishRelay<AlertViewModel>()
    
    let passwordRecoveryAttempt = PublishRelay<Void>()
    let loginAttempt = PublishRelay<Void>()
    let dismiss = PublishRelay<Void>()
        
    
    private weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?
    private let disposeBag = DisposeBag()
    
    init(coordinatorDelegate: LoginViewModelCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
                
        let isEmailValid = email.throttle(.milliseconds(500), scheduler: MainScheduler.instance).map({ NSPredicate.emailPredicate.evaluate(with: $0) })
        let isPasswordValid = password.map({ $0.count > 6 && $0.count < 255 })
        
        isLoginEnabled = Observable.combineLatest(isEmailValid, isPasswordValid).map({ $0 && $1})
                
        loginAttempt
            .withLatestFrom(isLoginEnabled)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (validated) in
                if validated {
                    //FIXME: add actual request to backend API
                    //...
                    self.coordinatorDelegate?.login()
                } else {
                    let alert = AlertViewModel(error: LoginError.notValidatedCredentials)
                    self.alert.accept(alert)
                }
            })
            .disposed(by: disposeBag)
        
        dismiss
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (_) in
                self.coordinatorDelegate?.back()
            })
            .disposed(by: disposeBag)
                
        passwordRecoveryAttempt
            .subscribe(onNext: { (_) in
                print("recoveryButtonTap")
            })
            .disposed(by: disposeBag)
    }
    
    
}
