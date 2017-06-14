//
//  LoginViewModel.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
    func loginViewModel(_ viewModel: LoginViewModel, error: Error)
}

final class LoginViewModel {
    typealias Dependencies = HasAuthenticationController

    // MARK: - Private Properties
    private let dependencies: Dependencies

    // MARK: - Public Properties
    weak var delegate: LoginViewModelDelegate?

    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies

        dependencies.authenticationController.delegates.add(self)
    }
    deinit {
        dependencies.authenticationController.delegates.remove(self)
    }

    // MARK: - Public Functions
    func login<T: Authenticator>(using: T.Type) {
        dependencies.authenticationController.login(using: T.self)
    }
}

extension LoginViewModel: AuthenticationControllerDelegate {
    func authenticationLogin(controller: AuthenticationController, authentication: Authentication) { }
    func authenticationLogout(controller: AuthenticationController) { }
    func authenticationError(controller: AuthenticationController, error: Error) {
        delegate?.loginViewModel(self, error: error)
    }
}
