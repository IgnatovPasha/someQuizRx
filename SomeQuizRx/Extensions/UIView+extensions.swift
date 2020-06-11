//
//  UIView+extensions.swift
//  WeatherApp
//
//  Created by Pavel on 11.01.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func addGradient(_ gradientLayer:CAGradientLayer) {
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    func insertGradient(_ gradientLayer: CAGradientLayer, at index: UInt32 = 0, withFrame customframe: CGRect? = nil) {
        if let customFrame = customframe {
            gradientLayer.frame = customFrame
        } else {
            gradientLayer.frame = bounds
        }
        layer.insertSublayer(gradientLayer, at: index)
    }

    func roundCorners(radius: CGFloat, masksToBounds: Bool, maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        layer.maskedCorners = maskedCorners
        layer.cornerRadius = radius
        layer.masksToBounds = masksToBounds
    }
    func addContentView(_ contentView:UIView) {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate(
            [contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
             contentView.widthAnchor.constraint(equalTo: self.widthAnchor),
             contentView.heightAnchor.constraint(equalTo: self.heightAnchor)]
        )
    }
    //MARK: - Gradient border
    private static let kLayerNameGradientBorder = "GradientBorderLayer"

    public func setGradientBorder(width: CGFloat, gradient: CAGradientLayer) -> CAGradientLayer {
        let existedBorder = gradientBorderLayer()
        let border = existedBorder ?? gradient
        border.frame = bounds
        border.masksToBounds = true

        let mask = CAShapeLayer()
        mask.path = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = width

        border.mask = mask

        let exists = existedBorder != nil
        if !exists {
            layer.addSublayer(border)
        }
        return border
    }

    public func removeGradientBorder() {
        self.gradientBorderLayer()?.removeFromSuperlayer()
    }

    private func gradientBorderLayer() -> CAGradientLayer? {
        let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
        if borderLayers?.count ?? 0 > 1 {
            fatalError()
        }
        return borderLayers?.first as? CAGradientLayer
    }
}
