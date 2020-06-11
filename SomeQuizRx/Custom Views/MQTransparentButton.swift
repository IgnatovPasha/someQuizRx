//
//  MQTransparentButton.swift
//  MusiQuiz
//
//  Created by Pavel on 5/22/19.
//  Copyright © 2019 Yuriy  Troyan. All rights reserved.
//

import UIKit

class MQTransparentButton: UIButton {
    private let roundedPercentage: CGFloat = 0.2

    public func configure(title: String? = nil,
                          titleFont: UIFont = UIFont.systemFont(ofSize: 17),
                          titleColor: UIColor? = UIColor.white,
                          backgroundColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3),
                          backgroundHighlightedColor: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.29),
                          borderColor: UIColor = #colorLiteral(red: 1, green: 0.9960784314, blue: 0.9960784314, alpha: 0.27),
                          borderWidth: CGFloat = 1.0) {

        self.titleLabel?.font = titleFont
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(titleColor, for: .highlighted)

        self.backgroundColor = backgroundColor
        self.backgroundHighlightedColor = backgroundHighlightedColor
        self.setBorder(color: borderColor, width: borderWidth)
    }
    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil {
                setBackgroundColor(backgroundColor!, for: .normal)
            }
        }
    }
    public var backgroundHighlightedColor:UIColor? {
        didSet {
            if backgroundHighlightedColor != nil {
                setBackgroundColor(backgroundHighlightedColor!, for: .highlighted)
            }
        }
    }
    public func setBorder(color: UIColor, width: CGFloat) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        configure()
        roundCorners(radius: frame.height*roundedPercentage, masksToBounds: true)
    }
}
