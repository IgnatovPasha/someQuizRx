
//
//  MQScoreView.swift
//  MusiQuiz
//
//  Created by Pavel on 7/30/19.
//  Copyright © 2019 Pavel. All rights reserved.
//

import UIKit

class MQScoreView: UIView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var opacityView: UIView!

    @IBOutlet private weak var shopPointsCoinImageView: UIImageView!
    @IBOutlet private weak var gamePointsCoinImageView: UIImageView!
    @IBOutlet private weak var shopPointsLabel: UILabel!
    @IBOutlet private weak var gamePointsLabel: UILabel!

    public func updateScore(_ score: Score) {
        gamePointsLabel.text = String(score.gamePoints)
        shopPointsLabel.text = String(score.shopPoints)
        let viewsToAnimate = [
            shopPointsCoinImageView,
            gamePointsCoinImageView,
            shopPointsLabel,
            gamePointsLabel
        ]
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [.curveEaseInOut], animations: {

            let transformation = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewsToAnimate.forEach {$0?.transform = transformation}

        }) {(completed) in

            let backwardTransformation = CGAffineTransform.identity
            viewsToAnimate.forEach {$0?.transform = backwardTransformation}
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        privateInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        privateInit()
    }

    private func privateInit() {
        Bundle.main.loadNibNamed(MQScoreView.reuseIdentifier, owner: self, options: nil)
        self.addContentView(contentView)
        backgroundColor = UIColor.clear

        contentView.backgroundColor = UIColor.clear
        
        opacityView.insertGradient(CAGradientLayer.navBar)
        opacityView.roundCorners(radius: 14, masksToBounds: true)
        opacityView.layer.opacity = 0.3

    }

}
