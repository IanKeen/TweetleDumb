//
//  TweetsRequest.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct TweetsRequest: APIRequest {
    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        return NetworkRequest(
            method: .GET,
            url: baseURL.appendingPathComponent("/v1/tweets"),
            headers: [:],
            body: nil
        )
    }

    func handle(response: NetworkResponse) throws -> [Tweet] {
        guard
            let json = response.jsonArray as? [[String: Any]]
            else { throw NetworkError.invalidResponse(response) }

        return try json.compactMap(Tweet.init(json:))
    }
}
