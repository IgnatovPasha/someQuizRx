//
//  UIViewController+extensions.swift
//  WeatherApp
//
//  Created by Pavel on 12.01.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

extension UIViewController {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
