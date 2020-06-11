//
//  MyTextField.swift
//  MusiQuizRx
//
//  Created by Pavel on 04.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    @IBInspectable
    private var cornerRadiusRate: CGFloat = 0 {
        didSet {
            if cornerRadiusRate > 50 {
                cornerRadiusRate = 50
            }
            if cornerRadiusRate < 0 {
                cornerRadiusRate = 0
            }
            updateCorners()
        }
    }
    
    @IBInspectable
    private var sidePadding: CGFloat = 24
    
    @IBInspectable
    private var placeholderTextColor: UIColor? {
        didSet {
            if placeholderTextColor != nil {
                attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderTextColor!])
            }
        }
    }

    @IBInspectable
    private var minXMinY: Bool {
        get {
            return maskedCorners.contains(.layerMinXMinYCorner)
        }
        set {
            if newValue {
                maskedCorners.insert(.layerMinXMinYCorner)
            } else {
                maskedCorners.remove(.layerMinXMinYCorner)
            }
        }
    }
    @IBInspectable
    private var maxXMinY: Bool {
        get {
            return maskedCorners.contains(.layerMaxXMinYCorner)
        }
        set {
            if newValue {
                maskedCorners.insert(.layerMaxXMinYCorner)
            } else {
                maskedCorners.remove(.layerMaxXMinYCorner)
            }
        }
    }
    @IBInspectable
    private var minXMaxY: Bool {
        get {
            return maskedCorners.contains(.layerMinXMaxYCorner)
        }
        set {
            if newValue {
                maskedCorners.insert(.layerMinXMaxYCorner)
            } else {
                maskedCorners.remove(.layerMinXMaxYCorner)
            }
        }
    }
    @IBInspectable
    private var maxXMaxY: Bool {
        get {
            return maskedCorners.contains(.layerMaxXMaxYCorner)
        }
        set {
            if newValue {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            } else {
                maskedCorners.remove(.layerMaxXMaxYCorner)
            }
        }
    }
    @IBInspectable
    private var activeBgColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2603433099)

    @IBInspectable
    private var inactiveBgColor: UIColor = .white {
        didSet {
            backgroundColor = inactiveBgColor
        }
    }
    
    public var roundedCorners: RoundedCorners = .none {
        didSet {
            maskedCorners = roundedCorners.mask
        }
    }
        
    enum RoundedCorners {
        case top
        case bottom
        case all
        case none
        
        fileprivate var mask: CACornerMask {
            switch self {
            case .top:
                return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .bottom:
                return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .all:
                return [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .none:
                return []
            }
        }
    }

    override var borderStyle: UITextField.BorderStyle {
        didSet {
            if borderStyle != .none {
                borderStyle = .none
            }
        }
    }
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        backgroundColor = activeBgColor
        return super.becomeFirstResponder()
    }
    @discardableResult
    override func resignFirstResponder() -> Bool {
        backgroundColor = inactiveBgColor
        return super.resignFirstResponder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x + sidePadding,
            y: bounds.origin.y + topPadding,
            width: bounds.size.width - sidePadding * 2,
            height: bounds.size.height - topPadding * 2
        )
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }

    private var maskedCorners: CACornerMask = [] {
        didSet {
            updateCorners()
        }
    }
    private func updateCorners() {
        let radius = cornerRadiusRate / 100 * frame.height
        roundCorners(radius: radius, masksToBounds: true, maskedCorners: maskedCorners)
    }
    private let topPadding: CGFloat = 8
}
