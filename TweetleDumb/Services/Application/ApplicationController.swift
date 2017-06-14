//
//  ApplicationController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationController {
    // MARK: - Private Properties
    private let environment: Environment
    fileprivate let navigationController: UINavigationController

    // MARK: - Public Properties
    private(set) lazy var authenticationController: AuthenticationController = AuthenticationController(
        api: self.api,
        storage: self.environment.keyValueStore,
        authenticators: self.environment.authenticators
    )
    private(set) lazy var api: API = API(
        network: self.environment.network,
        baseURL: self.environment.baseURL
    )

    // MARK: - Lifecycle
    init(environment: Environment, rootNavigationController: UINavigationController) {
        self.environment = environment
        self.navigationController = rootNavigationController
    }

    // MARK: - Public
    func start() {
        authenticationController.delegates.add(self)
        authenticationController.notifyDelegate()
    }
}

// MARK: - Error Handling
private extension ApplicationController {
    func handle(error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        navigationController.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Routing
private extension ApplicationController {
    func showLogin() {
        let viewModel = LoginViewModel(dependencies: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: navigationController.shouldAnimate)
        navigationController.setNavigationBarHidden(true, animated: navigationController.shouldAnimate)
    }
    func showTweets() {
        let viewModel = TweetsViewModel(dependencies: self)
        viewModel.delegate.add(self)
        let viewController = TweetsViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: navigationController.shouldAnimate)
        navigationController.setNavigationBarHidden(false, animated: navigationController.shouldAnimate)
    }
}

// MARK: - TweetsViewModelDelegate
extension ApplicationController: TweetsViewModelDelegate {
    func tweetsViewModelUpdated(_ viewModel: TweetsViewModel) {
        //
    }
    func tweetsViewModel(_ viewModel: TweetsViewModel, error: Error) {
        handle(error: error)
    }
}

// MARK: - AuthenticationControllerDelegate
extension ApplicationController: AuthenticationControllerDelegate {
    func authenticationError(controller: AuthenticationController, error: Error) {
        handle(error: error)
    }
    func authenticationLogin(controller: AuthenticationController, authentication: Authentication) {
        showTweets()
    }
    func authenticationLogout(controller: AuthenticationController) {
        showLogin()
    }
}
