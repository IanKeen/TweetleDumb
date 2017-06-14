//
//  LoginViewController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class LoginViewController: CustomViewController<LoginView, LoginViewModel> {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        customView.loginButton.addTarget(self, action: #selector(loginButtonTouchUpInside), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func loginButtonTouchUpInside(sender: UIButton) {
        customView.loginButton.isUserInteractionEnabled = false
        customView.activityIndicator.startAnimating()

        viewModel.login(using: MockTwitterAuthenticator.self)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func loginViewModel(_ viewModel: LoginViewModel, error: Error) {
        customView.loginButton.isUserInteractionEnabled = true
        customView.activityIndicator.stopAnimating()
    }
}
