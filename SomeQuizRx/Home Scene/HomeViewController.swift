//
//  HomeViewController.swift
//  MusiQuizRx
//
//  Created by Pavel on 02.03.2020.
//  Copyright © 2020 Pavel. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var scoreView: MQScoreView!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var appNameLabel: UILabel!
    @IBOutlet private weak var mottoLabel: UILabel!
    
    @IBOutlet private weak var playButton: ConvexButton!
    @IBOutlet private weak var contactsButton: MQTransparentButton!
    @IBOutlet private weak var settingsButton: MQTransparentButton!
    @IBOutlet private weak var faqButton: UIButton!
    
    
    var viewModel: HomeViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


}
