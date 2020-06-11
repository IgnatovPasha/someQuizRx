//
//  RegistrationViewModel.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//
import Foundation
import RxRelay
import RxSwift

enum RegistrationError: LocalizedError {
    case differentPasswords
    case notImplemented
    
    var errorDescription: String? {
        switch self {
        case .differentPasswords: return NSLocalizedString("Passwords should be equal. Please try again.", comment: "Error description")
        case .notImplemented: return NSLocalizedString("Sorry, but requested functionality is not implemented yet", comment: "Error description")
        }
    }
}

class RegistrationViewModel: RegistrationViewModelProtocol {
    let title = BehaviorRelay<String>(value: NSLocalizedString("Registration", comment: "Registration scene title"))
    
    var namePlaceholder: String = NSLocalizedString("Name", comment: "textfield placeholder")
    let emailPlaceholder: String = NSLocalizedString("E-mail", comment: "textfield placeholder")
    let passwordPlaceholder: String = NSLocalizedString("Password (min 6 characters)", comment: "textfield placeholder")
    var confirmPasswordPlaceholder: String = NSLocalizedString("Confirm Password", comment: "textfield placeholder")
    
    var name = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    var confirmPassword = BehaviorRelay<String>(value: "")
    
    let resolvedEmail: Observable<String>
    let isValidName: Observable<Bool>
    let isValidEmail: Observable<Bool>
    let isValidPassword: Observable<Bool>
    
    
    let isRegistrationEnabled: Observable<Bool>
    let alert = PublishRelay<AlertViewModel>()
    
    let registrationAttempt = PublishRelay<Void>()
    let dismiss = PublishRelay<Void>()
        
    
    private weak var coordinatorDelegate: RegistrationViewModelCoordinatorDelegate?
    private let disposeBag = DisposeBag()
    
    init(coordinatorDelegate: RegistrationViewModelCoordinatorDelegate) {
        self.coordinatorDelegate = coordinatorDelegate
              
        isValidName = name.map({ !$0.isEmpty })
        
        resolvedEmail = email
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map({$0.replacingOccurrences(of: " ", with: "")})
//            .share(replay: 1, scope: .forever)
        
        isValidEmail = resolvedEmail
            .map({ NSPredicate.emailPredicate.evaluate(with: $0) })
        
//        resolvedEmail
//            .bind(to: email)
//            .disposed(by: disposeBag)
        
//        isValidEmail = email.throttle(.milliseconds(500), scheduler: MainScheduler.instance)
//            .compactMap({ $0 })
//            .map({$0.last == " " ? String($0.dropLast()) : $0})
            
        
        isValidPassword = password.map({ $0.count >= 6 && $0.count < 255 })
        let arePasswordsEqual = Observable.combineLatest(password, confirmPassword).map {$0 == $1}
        
        
        isRegistrationEnabled = Observable.combineLatest(isValidName, isValidEmail, isValidPassword, arePasswordsEqual).map {$0 && $1 && $2 && $3}
        
        registrationAttempt
            .withLatestFrom(arePasswordsEqual)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (validated) in
                if validated {
                    let alert = AlertViewModel(error: RegistrationError.notImplemented)
                    self.alert.accept(alert)
                    //FIXME: add actual request to backend API
                    //...
//                    self.coordinatorDelegate?.register()
                } else {
                    let alert = AlertViewModel(error: RegistrationError.differentPasswords)
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
                
    }
    
    
}
