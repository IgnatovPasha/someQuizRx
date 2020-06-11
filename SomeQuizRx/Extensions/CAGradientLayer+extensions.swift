//
//  CAGradientLayer+extensions.swift
//  MusiQuiz
//
//  Created by Pavel on 5/20/19.
//  Copyright © 2019 Yuriy  Troyan. All rights reserved.
//

import Foundation
import UIKit
extension CAGradientLayer {
    static var callToAction:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.buttonCTA1, endColor: UIColor.buttonCTA2)
    }
    static var shopButton:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.buttonShop1, endColor: UIColor.buttonShop2)
    }
    static var navBar:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.navBar1, endColor: UIColor.navBar2)
    }
    static var borderCorrect:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.borderCorrect1, endColor: UIColor.borderCorrect2, isVertical: false)
    }
    static var panelCorrect:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.panelCorrect, endColor: UIColor.clear, isVertical: false)
    }
    static var panelIncorrect:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.panelIncorrect, endColor: UIColor.clear, isVertical: false)
    }
    static var equlizer:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.equalizer1, endColor: UIColor.equalizer2)
    }
    static var alert:CAGradientLayer {
        return gradientLayerWith(startColor: UIColor.alert1, endColor: UIColor.alert2)
    }
    static var bottomView: CAGradientLayer {
         return gradientLayerWith(startColor: UIColor.bottomView1, endColor: UIColor.bottomView2)
    }

    private static func gradientLayerWith(startColor:UIColor, endColor:UIColor, isVertical:Bool = true) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = isVertical ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = isVertical ? CGPoint(x: 0.5, y: 1.0) : CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [startColor, endColor].compactMap({ $0.cgColor })
        return gradientLayer
    }

}
