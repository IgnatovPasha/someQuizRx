//
//  LoginViewController.swift
//  MusiQuizRx
//
//  Created by Pavel on 03.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var customNavBar: CustomNavBarView!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var emailTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    @IBOutlet private weak var recoverPasswordButton: UIButton!
    
    @IBOutlet private weak var customNavBarHeightConstraint: NSLayoutConstraint!
    
    var viewModel: LoginViewModelProtocol!
    private let disposeBag = DisposeBag()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureConstraints()
        
        emailTextField.placeholder = viewModel.emailPlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        
        customNavBar.leftButton.rx.tap
            .bind(to: viewModel.dismiss)
            .disposed(by: disposeBag)
        
        customNavBar.rightButton.rx.tap
            .bind(to: viewModel.loginAttempt)
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.recoveryTitle
            .bind(to: recoverPasswordButton.rx.title())
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.primaryActionTriggered)
            .bind(onNext: { (_) in
                self.passwordTextField.becomeFirstResponder()
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.primaryActionTriggered).asObservable()
            .bind(to: viewModel.loginAttempt)
            .disposed(by: disposeBag)
                    
        recoverPasswordButton.rx.tap
            .bind(to: viewModel.passwordRecoveryAttempt)
            .disposed(by: disposeBag)
        
        viewModel.isLoginEnabled
            .bind(to: customNavBar.rightButton.rx.isEnabled)
            .disposed(by: disposeBag)
                
        viewModel.alert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (alert) in
                UIAlertController.presentSimpleAlert(alert, from: self)
            })
            .disposed(by: disposeBag)
        
        let tapRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(tapRecognizer)
        
        tapRecognizer.rx.event
            .bind(onNext: { [unowned self] (recognizer) in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    func configureConstraints() {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        customNavBarHeightConstraint.constant = statusBarHeight + 44
    }
}
