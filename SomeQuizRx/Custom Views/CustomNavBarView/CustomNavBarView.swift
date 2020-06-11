//
//  CustomNavBarView.swift
//
//  Created by Pavel on 5/28/19.
//  Copyright © 2019 Yuriy  Troyan. All rights reserved.
//

import UIKit

@IBDesignable
class CustomNavBarView: UIView {
    private var contentView: UIView!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var rightImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    
    @IBInspectable
    var leftButtonImage: UIImage? {
        get {
            return leftButton.image(for: .normal)
        }
        set {
            leftButton.setImage(newValue, for: .normal)
        }
    }
    
    @IBInspectable
    var rightButtonImage: UIImage? {
        get {
            return rightButton.image(for: .normal)
        }
        set {
            rightButton.setImage(newValue, for: .normal)
        }
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    private func customInit() {
        contentView = loadViewFromNib()
        addContentView(contentView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: CustomNavBarView.self)
        let nib = UINib(nibName: CustomNavBarView.reuseIdentifier, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
