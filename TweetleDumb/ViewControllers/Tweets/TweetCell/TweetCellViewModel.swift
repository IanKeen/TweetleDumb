//
//  TweetCellViewModel.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

final class TweetCellViewModel {
    // MARK: - Private Properties
    private let tweet: Tweet

    // MARK: - Public Properties
    var text: String { return tweet.text }
    var posted: String { return tweet.posted.makeString() }
    var user: String { return "\(tweet.user.realName) (\(tweet.user.handle))" }

    // MARK: - Lifecycle
    init(tweet: Tweet) {
        self.tweet = tweet
    }
}

extension TweetCellViewModel: TableViewCellRepresentable {
    typealias TableViewCell = TweetCell
}
