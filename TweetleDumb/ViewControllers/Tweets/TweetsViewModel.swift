//
//  TweetsViewModel.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol TweetsViewModelDelegate: class {
    func tweetsViewModelUpdated(_ viewModel: TweetsViewModel)
    func tweetsViewModel(_ viewModel: TweetsViewModel, error: Error)
}

final class TweetsViewModel {
    typealias Dependencies = HasAPI

    // MARK: - Private Properties
    private let dependencies: Dependencies
    private var working = false

    // MARK: - Public Properties
    let delegate = MulticastDelegate<TweetsViewModelDelegate>()
    let cells: [TableViewCellViewModel.Type] = [TweetCellViewModel.self]
    private(set) var dataSet: [TableViewCellViewModel] = [] {
        didSet {
            delegate.notify { $0.tweetsViewModelUpdated(self) }
        }
    }

    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public Functions
    func reloadData() {
        guard !working else { return }

        working = true
        let request = TweetsRequest()

        dependencies.api.execute(request: request) { [weak self] result in
            guard let this = self else { return }

            switch result {
            case .success(let tweets):
                this.dataSet = tweets
                    .sorted(by: { $0.posted > $1.posted })
                    .map(TweetCellViewModel.init)

            case .failure(let error):
                this.delegate.notify { $0.tweetsViewModel(this, error: error) }
            }

            this.working = false
        }
    }
}
