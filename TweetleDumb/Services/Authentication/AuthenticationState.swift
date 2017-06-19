//
//  AuthenticationState.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension AuthenticationState {
    enum State {
        case loggedIn(Authentication)
        case loggedOut
    }
}

extension AuthenticationState {
    enum StorageKey {
        static let authentication = "authentication"
    }
}

protocol AuthenticationStateDelegate: class {
    func authenticationStateUpdated(_ authenticationState: AuthenticationState, from old: Authentication?, to new: Authentication?)
}

protocol ReadOnlyAuthenticationState {
    var delegates: MulticastDelegate<AuthenticationStateDelegate> { get }
    var authentication: Authentication? { get }
}

extension AuthenticationState: ReadOnlyAuthenticationState { }

final class AuthenticationState {
    // MARK: - Private Properties
    private let storage: KeyValueStore

    // MARK: - Public Properties
    var readOnly: ReadOnlyAuthenticationState { return self }
    let delegates = MulticastDelegate<AuthenticationStateDelegate>()
    var authentication: Authentication? {
        didSet {
            switch (oldValue, authentication) {
            case (.some, .none): // logged in > logout
                clearAuthentication()
                delegates.notify { $0.authenticationStateUpdated(self, from: oldValue, to: authentication) }

            case (.none, .some(let auth)): // logged out > login
                store(authentication: auth)
                delegates.notify { $0.authenticationStateUpdated(self, from: oldValue, to: auth) }

            default:
                // invalid transition's are:
                // - logged in > login
                // - logged out > logout
                print("This transition shouldn't happen")
            }
        }
    }

    // MARK: - Lifecycle
    init(storage: KeyValueStore) {
        self.storage = storage

        // we assign a value here so we don't trigger the property observer
        authentication = storedAuthentication()
    }

    // MARK: - Private Functions
    private func storedAuthentication() -> Authentication? {
        guard let json: [String: Any] = storage.get(key: StorageKey.authentication)
            else { return nil }

        return try? Authentication(json: json)
    }
    private func store(authentication: Authentication) {
        storage.set(
            value: authentication.makeDictionary(),
            forKey: StorageKey.authentication
        )
    }
    private func clearAuthentication() {
        storage.remove(key: StorageKey.authentication)
    }
}
