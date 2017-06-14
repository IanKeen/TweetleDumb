//
//  ComposeViewModelTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

private class Dependencies: HasAPI, HasAuthenticationController, HasAuthenticationState, HasReadOnlyAuthenticationState {
    private(set) lazy var api: API = mockApi()
    private(set) lazy var authenticationController: AuthenticationController = AuthenticationController(
        api: self.api,
        authenticationState: self.authenticationState,
        authenticators: [MockTwitterAuthenticator()]
    )
    private(set) lazy var authenticationState: AuthenticationState = mockAuthenticationState()
}

private class Delegate: ComposeViewModelDelegate {
    typealias OnError = (Error) -> Void
    typealias OnNewTweet = (Tweet) -> Void
    typealias OnCancel = () -> Void

    private let onError: OnError
    private let onNewTweet: OnNewTweet
    private let onCancel: OnCancel

    init(onError: @escaping OnError, onNewTweet: @escaping OnNewTweet, onCancel: @escaping OnCancel) {
        self.onError = onError
        self.onNewTweet = onNewTweet
        self.onCancel = onCancel
    }

    func composeViewModelCancel(_ viewModel: ComposeViewModel) { onCancel() }
    func composeViewModel(_ viewModel: ComposeViewModel, error: Error) { onError(error) }
    func composeViewModel(_ viewModel: ComposeViewModel, newTweet: Tweet) { onNewTweet(newTweet) }
}

enum StringError {
    case `nil`, empty
}

class ComposeViewModelTests: XCTestCase {
    func testComposeViewModel_Compose_Errors() {
        let nilText = expectation(description: "nilText")
        let emptyText = expectation(description: "emptyText")
        let tooLong = expectation(description: "tooLong")
        let auth = expectation(description: "auth")

        var stringError: StringError = .nil

        let dependencies = Dependencies()
        let viewModel = ComposeViewModel(dependencies: dependencies)

        let delegate = Delegate(
            onError: { error in
                switch error {
                case ComposeViewModel.Error.noText:
                    switch stringError {
                    case .nil:
                        nilText.fulfill()
                        stringError = .empty
                    case .empty:
                        emptyText.fulfill()
                    }
                case ComposeViewModel.Error.textTooLong:
                    tooLong.fulfill()
                case AuthenticationController.Error.authenticationRequired:
                    auth.fulfill()
                default:
                    XCTFail()
                }
            },
            onNewTweet: { _ in XCTFail() },
            onCancel: { XCTFail() }
        )

        viewModel.delegate.add(delegate)
        viewModel.compose(with: nil)
        viewModel.compose(with: "")
        viewModel.compose(with: [String](repeating: " ", count: viewModel.maxLength + 1).joined())

        dependencies.authenticationController.logout()
        viewModel.compose(with: "valid string")

        wait(for: [nilText, emptyText, tooLong, auth], timeout: 1.0, enforceOrder: true)
    }
    func testComposeViewModel_Compose_Success() {
        let exp = expectation(description: "")

        let dependencies = Dependencies()
        let viewModel = ComposeViewModel(dependencies: dependencies)

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onNewTweet: { tweet in
                exp.fulfill(when: tweet.text, equals: "valid string")
        },
            onCancel: { XCTFail() }
        )

        viewModel.delegate.add(delegate)
        viewModel.compose(with: "valid string")

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testComposeViewModel_Cancel() {
        let exp = expectation(description: "")

        let dependencies = Dependencies()
        let viewModel = ComposeViewModel(dependencies: dependencies)

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onNewTweet: { _ in XCTFail() },
            onCancel: { exp.fulfill() }
        )

        viewModel.delegate.add(delegate)
        viewModel.cancel()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
