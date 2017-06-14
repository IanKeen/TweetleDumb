//
//  ComposeViewController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class ComposeViewController: CustomViewController<ComposeView, ComposeViewModel> {
    // MARK: - Private Properties
    private lazy var keyboardObserver: KeyboardObserver = KeyboardObserver(container: self.view)

    // MARK: - Lifecycle
    required init(viewModel: ComposeViewModel) {
        super.init(viewModel: viewModel)

        title = "Compose"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelBarButtonItemTouchUpInside)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(submitBarButtonItemTouchUpInside)
        )
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        viewModel.delegate.remove(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate.add(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyboardObserver.start()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.tweetTextView.becomeFirstResponder()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        keyboardObserver.stop()
    }

    // MARK: - Actions
    @objc private func cancelBarButtonItemTouchUpInside(sender: UIBarButtonItem) {
        customView.tweetTextView.resignFirstResponder()
        viewModel.cancel()
    }
    @objc private func submitBarButtonItemTouchUpInside(sender: UIBarButtonItem) {
        customView.tweetTextView.resignFirstResponder()
        customView.tweetTextView.isUserInteractionEnabled = false

        [navigationItem.leftBarButtonItem, navigationItem.rightBarButtonItem]
            .forEach { $0?.isEnabled = false }

        customView.activityIndicator.startAnimating()

        viewModel.compose(with: customView.tweetTextView.text)
    }
}

extension ComposeViewController: ComposeViewModelDelegate {
    func composeViewModel(_ viewModel: ComposeViewModel, error: Error) {
        customView.tweetTextView.isUserInteractionEnabled = true

        [navigationItem.leftBarButtonItem, navigationItem.rightBarButtonItem]
            .forEach { $0?.isEnabled = true }

        customView.activityIndicator.stopAnimating()

        customView.tweetTextView.becomeFirstResponder()
    }
    func composeViewModel(_ viewModel: ComposeViewModel, newTweet: Tweet) { }
    func composeViewModelCancel(_ viewModel: ComposeViewModel) { }
}
