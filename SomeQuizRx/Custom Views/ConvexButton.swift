//
//  ConvexButton.swift
//  MusiQuiz
//
//  Created by Pavel on 5/21/19.
//  Copyright © 2019 Yuriy  Troyan. All rights reserved.
//

import UIKit

enum ConvexButtonStyle {
    case `default` //reloading
    case sticky
}

class ConvexButton: UIButton {

    public var style: ConvexButtonStyle = .default

    public var titleColor: UIColor = .textTitle {
        didSet {
            customTitleLabel.textColor = titleColor
        }
    }
    public var customFont: UIFont? = UIFont.mainButtons {
        didSet {
            customTitleLabel.font = customFont
        }
    }
            
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle("", for: state)
        customTitleLabel.text = title
    }

    internal lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.textTitle
        label.font = customFont
        return label
    }()

    public var titleView: UIView? {
        return customTitleLabel
    }
    
    override var isEnabled: Bool {
        didSet {
            if let gradient = gradient {
                gradient.opacity = isEnabled ? 1 : 0
            }
            bottomColor = isEnabled ? .buttonCTAPadding : .buttonCATDisabledPadding
            style = isEnabled ? .default : .sticky
        }
    }

    private let zValue: CGFloat = 5
    private let roundedPercentage: CGFloat = 0.2
    private var behindView = UIView()
    private var frontView = UIView()
    private var gradient: CAGradientLayer?


    private var pressed: Bool = false {
        didSet(oldValue) {
            if oldValue != pressed {
                updatePressedStatus()
            }
        }
    }

    private var topColor: UIColor = .buttonCTADisabled {
        didSet(oldValue) {
            frontView.backgroundColor = topColor
        }
    }
    private var borderColor: UIColor = .black {
        didSet(oldValue) {
            frontView.layer.borderColor = borderColor.cgColor
        }
    }
    private var borderWidth: CGFloat = 0 {
        didSet(oldValue) {
            frontView.layer.borderWidth = borderWidth
        }
    }

    private var bottomColor: UIColor = .buttonCTAPadding {
        didSet(oldValue) {
            behindView.backgroundColor = bottomColor
        }
    }

    override func awakeFromNib() {
        backgroundColor = UIColor.clear
        prepareBehindView()
        prepareFrontView()
        prepareTitleView()

        isUserInteractionEnabled = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        behindView.frame = frame
        behindView.frame.origin = CGPoint(x: 0, y: 0)
        behindView.frame.origin.y += zValue
        frontView.frame = frame
        frontView.frame.origin = CGPoint(x: 0, y: 0)
        titleView?.frame = frame
        titleView?.frame.origin = CGPoint(x: 0, y: 0)

        if let gradient = gradient {
            gradient.frame = frontView.bounds
        }

    }

    private func prepareBehindView() {
        behindView.frame = frame
        addSubview(behindView)
        behindView.frame.origin = CGPoint(x: 0, y: 0)
        behindView.frame.origin.y += zValue
        behindView.layer.borderWidth = 0.0
        behindView.layer.cornerRadius = frame.height*roundedPercentage
        behindView.backgroundColor = bottomColor
    }

    private func prepareFrontView() {
        frontView.frame = frame
        addSubview(frontView)
        frontView.frame.origin = CGPoint(x: 0, y: 0)
        let gradientLayer = CAGradientLayer.callToAction
        frontView.addGradient(gradientLayer)
        gradient = gradientLayer
        frontView.layer.borderWidth = 0.0
        frontView.layer.cornerRadius = frame.height*roundedPercentage
        frontView.backgroundColor = topColor
        frontView.layer.masksToBounds = true
    }
    private func prepareTitleView() {
        if let anyView = titleView {
            anyView.frame = frame
            addSubview(anyView)
            anyView.frame.origin = CGPoint(x: 0, y: 0)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if style == .sticky {
            if pressed == false {
                pressed = !pressed
            }
        } else {
            pressed = true
        }

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if style != .sticky {
            pressed = false
        }
        if let touch = touches.first?.location(in: self.superview!), frame.contains(touch) {
            sendActions(for: .touchUpInside)
        }
    }

    private func updatePressedStatus() {
        if pressed == false {
            frontView.frame.origin.y -= zValue
            titleView?.frame.origin.y -= zValue
        } else {
            frontView.frame.origin.y += zValue
            titleView?.frame.origin.y += zValue
        }
    }
}
