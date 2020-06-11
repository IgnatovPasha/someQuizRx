//
//  NSPredicate+extensions.swift
//  MusiQuizRx
//
//  Created by Pavel on 04.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import Foundation

extension NSPredicate {
    static let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
}
