//
//  TweetsViewController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class TweetsViewController: CustomViewController<TweetsView, TweetsViewModel> {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tweets"

        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)

        viewModel.delegate.add(self)
        viewModel.reloadData()
    }
    deinit {
        viewModel.delegate.remove(self)
    }

    // MARK: - Actions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
}

extension TweetsViewController: TweetsViewModelDelegate {
    func tweetsViewModel(_ viewModel: TweetsViewModel, error: Error) {
        //
    }
    func tweetsViewModelUpdated(_ viewModel: TweetsViewModel) {
        customView.reloadData()
    }
}
