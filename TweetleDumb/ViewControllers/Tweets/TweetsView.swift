//
//  TweetsView.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class TweetsView: UITableView {
    // MARK: - Lifecycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 100

        separatorStyle = .none

        refreshControl = UIRefreshControl()
    }
}
