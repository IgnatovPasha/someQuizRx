//
//  StoryboardInstantiatable.swift
//  WeatherApp
//
//  Created by Pavel on 13.01.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

protocol StoryboardInstantiatable {
    static func instantiate() -> Self
}

extension StoryboardInstantiatable where Self: UIViewController {
    static func instantiate() -> Self {
        let id = Self.reuseIdentifier
        let sb = UIStoryboard(name: "Main", bundle: Bundle.main)
        return sb.instantiateViewController(identifier: id) as! Self
    }
}
