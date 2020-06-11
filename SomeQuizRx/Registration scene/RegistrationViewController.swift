//
//  RegistrationViewController.swift
//  MusiQuizRx
//
//  Created by Pavel on 04.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class RegistrationViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var customNavBar: CustomNavBarView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    
    @IBOutlet private weak var nameTextField: DesignableTextField!
    @IBOutlet private weak var emailTextField: DesignableTextField!
    @IBOutlet private weak var passwordTextField: DesignableTextField!
    @IBOutlet private weak var repeatPasswordTextField: DesignableTextField!
    
    @IBOutlet private weak var customNavBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var textInputCenterYConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    private let textInputShift = PublishRelay<CGFloat>()
    private let firstResponder = PublishRelay<UITextField>()
    
    
    var viewModel: RegistrationViewModelProtocol!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureConstraints()
        
        nameTextField.placeholder = viewModel.namePlaceholder
        emailTextField.placeholder = viewModel.emailPlaceholder
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        repeatPasswordTextField.placeholder = viewModel.confirmPasswordPlaceholder
        
        // NavBar button taps binding to viewModel
        customNavBar.leftButton.rx.tap
            .bind(to: viewModel.dismiss)
            .disposed(by: disposeBag)
        
        customNavBar.rightButton.rx.tap
            .bind(to: viewModel.registrationAttempt)
            .disposed(by: disposeBag)
        
        //TextFields' binding to viewModel
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        repeatPasswordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.confirmPassword)
            .disposed(by: disposeBag)
        
        //ViewModel Observables binding to IBOutlets
        viewModel.title
            .observeOn(MainScheduler.instance)
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.resolvedEmail
            .observeOn(MainScheduler.instance)
            .bind(to: emailTextField.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.isRegistrationEnabled
            .bind(to: customNavBar.rightButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        let isValidName = viewModel.isValidName.share(replay: 1, scope: .forever)
        
        isValidName
            .map({ (valid) -> DesignableTextField.RoundedCorners in
                valid ? .top : .all
            })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] (roundedCorners) in
                self.nameTextField.roundedCorners = roundedCorners
            })
            .disposed(by: disposeBag)
        
        isValidName
            .map {!$0}
            .observeOn(MainScheduler.instance)
            .bind(to: emailTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        let isValidEmail = viewModel.isValidEmail.share(replay: 1, scope: .forever)
        
        isValidEmail
            .map {!$0}
            .observeOn(MainScheduler.instance)
            .bind(to: passwordTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        isValidEmail
            .map({ (valid) -> DesignableTextField.RoundedCorners in
                valid ? .none : .bottom
            })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] (roundedCorners) in
                self.emailTextField.roundedCorners = roundedCorners
            })
            .disposed(by: disposeBag)
        
        let isValidPassword = viewModel.isValidPassword.share(replay: 1, scope: .forever)
        
        isValidPassword
            .map {!$0}
            .observeOn(MainScheduler.instance)
            .bind(to: repeatPasswordTextField.rx.isHidden)
            .disposed(by: disposeBag)
        
        isValidPassword
            .compactMap({$0 ? nil : ""})
            .observeOn(MainScheduler.instance)
            .bind(to: repeatPasswordTextField.rx.text)
            .disposed(by: disposeBag)
        
        isValidPassword
            .map({ (valid) -> DesignableTextField.RoundedCorners in
                valid ? .none : .bottom
            })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] (roundedCorners) in
                self.passwordTextField.roundedCorners = roundedCorners
            })
            .disposed(by: disposeBag)
        
        //Observing TextFields 'return' events and making next textField as firstResponder
        nameTextField.rx.controlEvent(.primaryActionTriggered)
            .filter({ [unowned self] in self.emailTextField.isHidden == false })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] in self.emailTextField.becomeFirstResponder() })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.primaryActionTriggered)
             .filter({ [unowned self] in self.passwordTextField.isHidden == false })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] in self.passwordTextField.becomeFirstResponder() })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.primaryActionTriggered)
            .filter({ [unowned self] in self.repeatPasswordTextField.isHidden == false })
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [unowned self] in self.repeatPasswordTextField.becomeFirstResponder() })
            .disposed(by: disposeBag)
        
        repeatPasswordTextField.rx.controlEvent(.primaryActionTriggered)
            .bind(to: viewModel.registrationAttempt)
            .disposed(by: disposeBag)
        
        //
        
        
        viewModel.alert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (alert) in
                UIAlertController.presentSimpleAlert(alert, from: self)
            })
            .disposed(by: disposeBag)
        
        //Handling touches outside of textFields
        let tapRecognizer = UITapGestureRecognizer()
        view.addGestureRecognizer(tapRecognizer)
        
        tapRecognizer.rx.event
            .bind(onNext: { [unowned self] (recognizer) in
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        //Making firstResponder-textField always visible over keyboard
        let keyboardFrame = RxKeyboard.instance.frame.asObservable()
        
        nameTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.firstResponder.accept(self.nameTextField)
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.firstResponder.accept(self.emailTextField)
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.firstResponder.accept(self.passwordTextField)
            })
            .disposed(by: disposeBag)
        
        repeatPasswordTextField.rx.controlEvent(.editingDidBegin)
            .subscribe(onNext: { [unowned self] _ in
                self.firstResponder.accept(self.repeatPasswordTextField)
            })
            .disposed(by: disposeBag)
        
        firstResponder
            .withLatestFrom(keyboardFrame, resultSelector: shiftResultWithTextFieldAndRect)
            .bind(to: textInputShift)
            .disposed(by: disposeBag)
        
        keyboardFrame
            .withLatestFrom(firstResponder, resultSelector: shiftResultWithRectAndTextField)
            .bind(to: textInputShift)
            .disposed(by: disposeBag)
            
        
        textInputShift
            .distinctUntilChanged()
            .compactMap({[unowned self] in $0 != self.textInputCenterYConstraint.constant ? $0 : nil})
            .delay(.milliseconds(120), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (shift) in
                UIView.animate(withDuration: 0.1) {
                    self.textInputCenterYConstraint.constant = shift
                    self.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func configureConstraints() {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            statusBarHeight = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        customNavBarHeightConstraint.constant = statusBarHeight + 44
    }
    
    private lazy var shiftResultWithRectAndTextField: (CGRect, UITextField) -> CGFloat = { [unowned self] (keyboardRect, textField) in
        return self.shiftResultWithTextFieldAndRect(textField, keyboardRect)
    }
    
    private lazy var shiftResultWithTextFieldAndRect: (UITextField, CGRect) -> CGFloat = { [unowned self] (textField, keyboardRect) in
        let convertedTextFieldRect = self.view.convert(textField.frame, from: nil)
        guard keyboardRect.intersects(convertedTextFieldRect) else { return 0 }
        let shift = (convertedTextFieldRect.origin.y + convertedTextFieldRect.height) - keyboardRect.origin.y
        return -shift - 10
    }
}
