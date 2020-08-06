//
//  ComposeViewModel.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol ComposeViewModelDelegate: class {
    func composeViewModelCancel(_ viewModel: ComposeViewModel)
    func composeViewModel(_ viewModel: ComposeViewModel, error: Error)
    func composeViewModel(_ viewModel: ComposeViewModel, newTweet: Tweet)
}

final class ComposeViewModel {
    typealias Dependencies = HasAPI & HasReadOnlyAuthenticationState

    // MARK: - Private Properties
    private let dependencies: Dependencies

    // MARK: - Public Properties
    let maxLength = 140
    let delegate = MulticastDelegate<ComposeViewModelDelegate>()

    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public
    func compose(with text: String?) {
        guard let text = text, !text.isEmpty
            else { return delegate.notify { $0.composeViewModel(self, error: Error.noText) } }

        guard text.count <= maxLength
            else { return delegate.notify { $0.composeViewModel(self, error: Error.textTooLong(maxLength)) } }

        guard let authentication = dependencies.readOnlyAuthenticationState.authentication
            else { return delegate.notify { $0.composeViewModel(self, error: AuthenticationController.Error.authenticationRequired) } }

        let tweet = Tweet(
            id: 999,
            text: text,
            posted: Date(),
            user: authentication.user
        )

        let request = ComposeRequest(tweet: tweet)

        dependencies.api.execute(request: request) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let newTweet):
                this.delegate.notify { $0.composeViewModel(this, newTweet: newTweet) }

            case .failure(let error):
                this.delegate.notify { $0.composeViewModel(this, error: error) }
            }
        }
    }
    func cancel() {
        delegate.notify { $0.composeViewModelCancel(self) }
    }
}
