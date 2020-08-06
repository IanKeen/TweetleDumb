//
//  ComposeView.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class ComposeView: UIView {
    // MARK: - Elements
    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.tintColor = .black
        indicator.stopAnimating()
        return indicator
    }()
    private(set) lazy var tweetTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 30)
        return textView
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    private func configure() {
        backgroundColor = .white

        [tweetTextView, activityIndicator]
            .forEach(addSubview)

        activityIndicator.center(in: self)
        tweetTextView.fill(self)
    }
}
