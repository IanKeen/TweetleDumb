//
//  TweetsViewController.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class TweetsViewController: CustomViewController<TweetsView, TweetsViewModel>, UITableViewDataSource {
    // MARK: - Lifecycle
    required init(viewModel: TweetsViewModel) {
        super.init(viewModel: viewModel)

        title = "Tweets"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutBarButtonItemTouchUpInside)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(composeBarButtonItemTouchUpInside)
        )
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        customView.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        customView.register(cells: viewModel.cells)
        customView.dataSource = self

        viewModel.delegate.add(self)
        customView.refreshControl?.beginRefreshing()
        viewModel.reloadData()
    }
    deinit {
        viewModel.delegate.remove(self)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.dataSet[indexPath.row].dequeue(from: tableView, at: indexPath)
    }

    // MARK: - Actions
    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        viewModel.reloadData()
    }
    @objc private func logoutBarButtonItemTouchUpInside(sender: UIBarButtonItem) {
        viewModel.logout()
    }
    @objc private func composeBarButtonItemTouchUpInside(sender: UIBarButtonItem) {
        viewModel.compose()
    }

}

extension TweetsViewController: TweetsViewModelDelegate {
    func tweetsViewModel(_ viewModel: TweetsViewModel, error: Error) {
        customView.refreshControl?.endRefreshing()
    }
    func tweetsViewModelUpdated(_ viewModel: TweetsViewModel) {
        customView.reloadData()
        customView.refreshControl?.endRefreshing()
    }
    func tweetsViewModelCompose(_ viewModel: TweetsViewModel) {
        //
    }
}
