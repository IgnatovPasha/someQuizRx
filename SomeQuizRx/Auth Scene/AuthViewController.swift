//
//  StartViewController.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthViewController: UIViewController, StoryboardInstantiatable {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var appNameLabel: UILabel!
    @IBOutlet private weak var mottoLabel: UILabel!
    @IBOutlet private weak var loginButton: MQTransparentButton!
    @IBOutlet private weak var registrationButton: ConvexButton!
    
    var viewModel: AuthViewModelProtocol!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        viewModel.appName
            .bind(to: appNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.motto
            .bind(to: mottoLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.loginOptionTitle
            .bind(to: loginButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.registrationOptionTitle
            .bind(to: registrationButton.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.login()
            })
            .disposed(by: disposeBag)
        
        registrationButton.rx.tap
            .subscribe(onNext: { (_) in
                self.viewModel.register()
            })
            .disposed(by: disposeBag)
        
    }
    
    
    
}
