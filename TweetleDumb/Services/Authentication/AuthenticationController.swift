//
//  AuthenticationController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol AuthenticationControllerDelegate {
    func authenticationError(controller: AuthenticationController, error: Swift.Error)
    func authenticationLogin(controller: AuthenticationController, authentication: Authentication)
    func authenticationLogout(controller: AuthenticationController)
}

extension AuthenticationController {
    enum StorageKey {
        static let authentication = "authentication"
    }
}

/// AuthenticationController is responsible for pairing an external auth with the
/// apps backend and keeping track of the authentication state for this session
final class AuthenticationController {
    // MARK: - Private Properties
    private let api: API
    private let authenticationState: AuthenticationState
    fileprivate let authenticators: [Authenticator]

    // MARK: - Public Properties
    let delegates = MulticastDelegate<AuthenticationControllerDelegate>()

    // MARK: - Lifecycle
    init(api: API, authenticationState: AuthenticationState, authenticators: [Authenticator]) {
        self.api = api
        self.authenticationState = authenticationState
        self.authenticators = authenticators

        authenticationState.delegates.add(self)
    }

    // MARK: - Public Functions
    func notifyDelegate() {
        switch authenticationState.authentication {
        case .none:
            delegates.notify { $0.authenticationLogout(controller: self) }

        case .some(let auth):
            delegates.notify { $0.authenticationLogin(controller: self, authentication: auth) }
        }
    }
    func login<T: Authenticator>(using authenticator: T.Type) {
        guard authenticationState.authentication == nil
            else { return send(error: Error.alreadyLoggedIn) }

        guard let authenticator = authenticators.first(where: { $0 is T })
            else { return send(error: Error.unsupportedAuthenticator) }

        authenticator.login { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .failure(let error):
                this.send(error: error)

            case .success(let token):
                let request = AuthenticationRequest(
                    authenticator: authenticator.name,
                    token: token
                )

                this.api.execute(
                    request: request,
                    complete: { response in
                        switch response {
                        case .failure(let error):
                            this.send(error: error)

                        case .success(let auth):
                            this.authenticationState.authentication = auth
                        }
                    }
                )

            }
        }
    }
    func logout() {
        guard authenticationState.authentication != nil
            else { return send(error: Error.alreadyLoggedOut) }

        authenticationState.authentication = nil
    }

    // MARK: - Private Functions
    private func send(error: Swift.Error) {
        delegates.notify { $0.authenticationError(controller: self, error: error) }
    }
}

extension AuthenticationController: AuthenticationStateDelegate {
    func authenticationStateUpdated(_ authenticationState: AuthenticationState, from old: Authentication?, to new: Authentication?) {
        switch (old, new) {
        case (.some, .none): // logged in > logout
            authenticators.forEach { $0.logout() }
            delegates.notify { $0.authenticationLogout(controller: self) }

        case (.none, .some(let auth)): // logged out > login
            delegates.notify { $0.authenticationLogin(controller: self, authentication: auth) }

        default:
            // invalid transition's are:
            // - logged in > login
            // - logged out > logout
            print("This transition shouldn't happen")
        }
    }
}
