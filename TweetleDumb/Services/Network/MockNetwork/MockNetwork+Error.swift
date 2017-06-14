//
//  MockNetwork+Error.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension MockNetwork {
    enum Error: LocalizedError {
        case invalidURL
        case random
        case fileSource

        var errorDescription: String? {
            switch self {
            case .random:
                return "Something went horribly wrong!"
            case .invalidURL:
                return "The provided URL was invalid"
            case .fileSource:
                return "Unable to obtain requested data"
            }
        }
    }
}
