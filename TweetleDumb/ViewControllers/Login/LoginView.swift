//
//  LoginView.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class LoginView: UIView {
    // MARK: - Elements
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TweetleDumb"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    private(set) lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        let title = NSAttributedString(
            string: "Login",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor: UIColor.white
            ]
        )
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.tintColor = .black
        indicator.stopAnimating()
        return indicator
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        backgroundColor = .white

        [label, activityIndicator, loginButton].forEach(addSubview)

        loginButton.heightAnchor.equal(to: 50)
        loginButton.leftAnchor.align(to: label.leftAnchor, offset: 10)
        loginButton.rightAnchor.align(to: label.rightAnchor, offset: -10)
        loginButton.centerYAnchor.align(to: centerYAnchor)

        activityIndicator.bottomAnchor.align(to: loginButton.topAnchor, offset: -10)
        activityIndicator.centerXAnchor.align(to: centerXAnchor)

        label.bottomAnchor.align(to: activityIndicator.topAnchor, offset: -10)
        label.heightAnchor.equal(to: 30)
        label.leftAnchor.align(to: leftAnchor, offset: 10)
        label.rightAnchor.align(to: rightAnchor, offset: -10)
    }
}
