//
//  TweetsViewModelTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

private class Dependencies: HasAPI, HasAuthenticationController {
    private(set) lazy var api: API = mockApi()
    private(set) lazy var authenticationController: AuthenticationController = mockAuthenticationController()
}

private class Delegate: TweetsViewModelDelegate {
    typealias OnError = (Error) -> Void
    typealias OnUpdate = () -> Void
    typealias OnCompose = () -> Void

    private let onError: OnError
    private let onUpdate: OnUpdate
    private let onCompose: OnCompose

    init(onError: @escaping OnError, onUpdate: @escaping OnUpdate, onCompose: @escaping OnCompose) {
        self.onError = onError
        self.onUpdate = onUpdate
        self.onCompose = onCompose
    }

    func tweetsViewModel(_ viewModel: TweetsViewModel, error: Error) { onError(error) }
    func tweetsViewModelUpdated(_ viewModel: TweetsViewModel) { onUpdate() }
    func tweetsViewModelCompose(_ viewModel: TweetsViewModel) { onCompose() }
}

class TweetsViewModelTests: XCTestCase {
    func testTweetsViewModel_Delegate_ReloadingData() {
        let exp = expectation(description: "")

        let dependencies = Dependencies()
        let viewModel = TweetsViewModel(dependencies: dependencies)

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onUpdate: { exp.fulfill() },
            onCompose: { XCTFail() }
        )

        viewModel.delegate.add(delegate)
        viewModel.reloadData()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
    func testTweetsViewModel_Delegate_Compose() {
        let exp = expectation(description: "")

        let dependencies = Dependencies()
        let viewModel = TweetsViewModel(dependencies: dependencies)

        let delegate = Delegate(
            onError: { _ in XCTFail() },
            onUpdate: { XCTFail() },
            onCompose: { exp.fulfill() }
        )

        viewModel.delegate.add(delegate)
        viewModel.compose()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
