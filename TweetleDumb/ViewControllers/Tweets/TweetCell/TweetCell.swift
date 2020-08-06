//
//  TweetCell.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class TweetCell: UITableViewCell {
    // MARK: - Elements
    fileprivate lazy var tweetLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()
    fileprivate lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 10)
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        [tweetLabel, dateLabel, userLabel]
            .forEach { contentView.addSubview($0) }

        userLabel.leftAnchor.align(to: contentView.leftAnchor, offset: 10)
        userLabel.bottomAnchor.align(to: contentView.bottomAnchor, offset: -10)
        userLabel.rightAnchor.align(to: dateLabel.leftAnchor, offset: -10)

        dateLabel.rightAnchor.align(to: contentView.rightAnchor, offset: -10)
        dateLabel.bottomAnchor.align(to: contentView.bottomAnchor, offset: -10)
        dateLabel.topAnchor.align(to: userLabel.topAnchor)

        tweetLabel.leftAnchor.align(to: contentView.leftAnchor, offset: 10)
        tweetLabel.rightAnchor.align(to: contentView.rightAnchor, offset: -10)
        tweetLabel.topAnchor.align(to: contentView.topAnchor, offset: 10)
        tweetLabel.bottomAnchor.align(to: userLabel.topAnchor, offset: -10)
    }
}

extension TweetCell: ViewModelConfigurable {
    func configure(with viewModel: TweetCellViewModel) {
        tweetLabel.text = viewModel.text
        userLabel.text = viewModel.user
        dateLabel.text = viewModel.posted
    }
}
