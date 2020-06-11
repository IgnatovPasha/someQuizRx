//
//  UIAlertController+extension.swift
//  WeatherApp
//
//  Created by Pavel on 13.01.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func presentSimpleAlert(_ viewModel: AlertViewModel, from vc: UIViewController) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: viewModel.okTitle, style: .default, handler: viewModel.okAction)
        alert.addAction(ok)
        if let cancelTitle = viewModel.cancelTitle {
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alert.addAction(cancel)
        }
        vc.present(alert, animated: true, completion: nil)
    }
}

struct AlertViewModel {
    let title: String
    let message: String?
    let okTitle: String?
    let okAction: ((UIAlertAction)->())?
    let cancelTitle: String?

    init(error: LocalizedError, okTitle: String? = "Ok", okAction: ((UIAlertAction)->())? = nil, cancelTitle: String? = nil) {
        self.title = "Error"
        self.message = error.localizedDescription
        self.okTitle = okTitle
        self.okAction = okAction
        self.cancelTitle = cancelTitle
    }
}
