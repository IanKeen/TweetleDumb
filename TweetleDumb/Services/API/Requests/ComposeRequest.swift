//
//  ComposeRequest.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct ComposeRequest: APIRequest {
    let tweet: Tweet

    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        return NetworkRequest(
            method: .POST,
            url: baseURL.appendingPathComponent("/v1/compose"),
            headers: [:],
            body: tweet.makeDictionary()
        )
    }

    func handle(response: NetworkResponse) throws -> Tweet {
        return tweet
    }
}
