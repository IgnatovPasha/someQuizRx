//
//  MQTextField.swift
//  MusiQuiz
//
//  Created by Pavel on 5/22/19.
//  Copyright © 2019 Yuriy  Troyan. All rights reserved.
//

import UIKit


class MQTextField: UITextField {
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

    private let sidePadding: CGFloat = 24
    private let topPadding: CGFloat = 8
    private let roundedPercentage: CGFloat = 0.2

    public func configure(backgroundColor: UIColor? = UIColor.textFieldBackground, font: UIFont? = UIFont.body, textColor: UIColor? = UIColor.white, placeholderTextColor: UIColor? = UIColor.textBodyInactive, borderStyle:UITextField.BorderStyle = .none, roundedCorners: MQTextField.RoundedCorners = .none) {

        self.backgroundColor = backgroundColor
        self.font = font
        self.textColor = textColor
        self.placeholderTextColor = placeholderTextColor
        self.borderStyle = .none
        self.roundedCorners = roundedCorners
    }
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isHighlighted ? UIColor.textFieldBackgroundHighlighted : UIColor.textFieldBackground
        }
    }
    var roundedCorners: RoundedCorners = .none {
        didSet {
            if roundedCorners != .none {
                roundCorners(radius: frame.height*roundedPercentage, masksToBounds: true, maskedCorners: roundedCorners.mask)
            } else {

            }
        }

    }
    private var placeholderTextColor: UIColor? {
        didSet {
            if placeholderTextColor != nil {
                attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : placeholderTextColor!])
            }
        }
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
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        configure()
        textAlignment = .left
    }

}
