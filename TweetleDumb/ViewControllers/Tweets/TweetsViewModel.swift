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

    // MARK: - Public Properties
    let delegate = MulticastDelegate<TweetsViewModelDelegate>()

    // MARK: - Lifecycle
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    // MARK: - Public Functions
    func reloadData() {
        print("Reload Data")
    }
}
