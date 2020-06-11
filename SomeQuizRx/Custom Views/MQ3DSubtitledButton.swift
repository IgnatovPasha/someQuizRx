//
//  MQ3DSubtitledButton.swift
//  MusiQuiz
//
//  Created by Pavel on 29.10.2019.
//  Copyright © 2019 Pavel. All rights reserved.
//

import UIKit

class MQ3DSubtitledButton: MQ3DButton {

    public var subtitle: String = "Subtitle" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    public var subtitleColor: UIColor = .textTitle {
        didSet {
            subtitleLabel.textColor = subtitleColor
        }
    }
    public var subtitleFont: UIFont? = UIFont.caption {
        didSet {
            subtitleLabel.font = subtitleFont
        }
    }

    internal lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = subtitleColor
        label.text = subtitle
        label.font = subtitleFont
        return label
    }()

    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    internal lazy var imageView: UIImageView = {
        let result = UIImageView()
        result.contentMode = .scaleAspectFit
        return result
    }()
    internal lazy var subtitleView: UIView = {
        let result = UIView()
        [subtitleLabel, imageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            result.addSubview($0)
        }
        let imageWidth: CGFloat = subtitleLabel.intrinsicContentSize.height
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: imageWidth),
            imageView.heightAnchor.constraint(equalToConstant: imageWidth),
            subtitleLabel.topAnchor.constraint(equalTo: result.topAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: result.bottomAnchor),
            subtitleLabel.centerXAnchor.constraint(equalTo: result.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor, constant: 3)
        ])

        return result
    }()

    internal lazy var titleSubtitleAndImageView: UIView = {
        let someView = UIView()
        [titleLabel, subtitleView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            someView.addSubview($0)
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: someView.leadingAnchor),
                $0.trailingAnchor.constraint(equalTo: someView.trailingAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: someView.centerYAnchor),
            subtitleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        ])
        return someView
    }()


    override var titleView: UIView? {
        return titleSubtitleAndImageView
    }
}

extension MQ3DSubtitledButton {
    public func configure(title: String, subtitle: String, image: UIImage?, onTouchHandler:@escaping (()->())) {
        self.title = title
        self.font = .mediumButtons
        self.subtitle = subtitle
        self.image = image
        self.onTouch = onTouchHandler
    }
}
