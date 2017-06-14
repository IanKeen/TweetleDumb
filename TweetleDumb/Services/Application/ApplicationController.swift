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
    private let navigationController: UINavigationController

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

private extension ApplicationController {
    func showLogin() {
        print(#function)
    }
    func showTweets() {
        print(#function)
    }
}

extension ApplicationController: AuthenticationControllerDelegate {
    func authenticationError(controller: AuthenticationController, error: Error) {
        print(error)
    }
    func authenticationLogin(controller: AuthenticationController, authentication: Authentication) {
        showTweets()
    }
    func authenticationLogout(controller: AuthenticationController) {
        showLogin()
    }
}
