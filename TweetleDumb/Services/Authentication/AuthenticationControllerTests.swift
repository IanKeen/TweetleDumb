//
//  AuthenticationControllerTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

private final class Delegate: AuthenticationControllerDelegate {
    typealias OnError = (Error) -> Void
    typealias OnLogin = (Authentication) -> Void
    typealias OnLogout = () -> Void

    private let onError: OnError
    private let onLogin: OnLogin
    private let onLogout: OnLogout

    init(onError: @escaping OnError, onLogin: @escaping OnLogin, onLogout: @escaping OnLogout) {
        self.onError = onError
        self.onLogin = onLogin
        self.onLogout = onLogout
    }

    func authenticationError(controller: AuthenticationController, error: Error) {
        onError(error)
    }
    func authenticationLogin(controller: AuthenticationController, authentication: Authentication) {
        onLogin(authentication)
    }
    func authenticationLogout(controller: AuthenticationController) {
        onLogout()
    }
}

class AuthenticationControllerTests: XCTestCase {
    func testAuthenticationController_Initial_Logout() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onLogin: { _ in XCTFail() },
            onLogout: { exp.fulfill() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: NSMutableDictionary(),
            authenticators: []
        )
        controller.delegates.add(delegate)
        controller.notifyDelegate()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testAuthenticationController_Initial_Login() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onLogin: { _ in exp.fulfill() },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: authenticationStorage(),
            authenticators: []
        )
        controller.delegates.add(delegate)
        controller.notifyDelegate()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testAuthenticationController_Error_UnsupportedAuth() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { exp.fulfill(when: $0, equals: AuthenticationController.Error.unsupportedAuthenticator) },
            onLogin: { _ in XCTFail() },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: NSMutableDictionary(),
            authenticators: []
        )
        controller.delegates.add(delegate)
        controller.login(using: MockTwitterAuthenticator.self)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testAuthenticationController_Error_LoggedIn() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { exp.fulfill(when: $0, equals: AuthenticationController.Error.alreadyLoggedIn) },
            onLogin: { _ in XCTFail() },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: authenticationStorage(),
            authenticators: []
        )
        controller.delegates.add(delegate)
        controller.login(using: MockTwitterAuthenticator.self)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testAuthenticationController_Error_LoggedOut() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { exp.fulfill(when: $0, equals: AuthenticationController.Error.alreadyLoggedOut) },
            onLogin: { _ in XCTFail() },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: NSMutableDictionary(),
            authenticators: []
        )
        controller.delegates.add(delegate)
        controller.logout()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testAuthenticationController_Login() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onLogin: { _ in exp.fulfill() },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: NSMutableDictionary(),
            authenticators: [MockTwitterAuthenticator()]
        )
        controller.delegates.add(delegate)
        controller.login(using: MockTwitterAuthenticator.self)

        waitForExpectations(timeout: 2.0, handler: nil)
    }
    func testAuthenticationController_Logout() {
        let exp = expectation(description: "")

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onLogin: { _ in XCTFail() },
            onLogout: { exp.fulfill() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: authenticationStorage(),
            authenticators: [MockTwitterAuthenticator()]
        )
        controller.delegates.add(delegate)
        controller.logout()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testAuthenticationController_Storage() {
        let exp = expectation(description: "")

        let storage = NSMutableDictionary()

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onLogin: { _ in exp.fulfill(when: { storage.value(forKey: AuthenticationController.StorageKey.authentication) != nil }) },
            onLogout: { XCTFail() }
        )
        let controller = AuthenticationController(
            api: api(),
            storage: storage,
            authenticators: [MockTwitterAuthenticator()]
        )
        controller.delegates.add(delegate)
        controller.login(using: MockTwitterAuthenticator.self)

        waitForExpectations(timeout: 2.0, handler: nil)
    }
}
