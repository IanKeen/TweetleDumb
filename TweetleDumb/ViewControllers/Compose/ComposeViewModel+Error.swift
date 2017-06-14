//
//  ComposeViewModel+Error.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension ComposeViewModel {
    enum Error: Swift.Error, LocalizedError {
        case noText
        case textTooLong(Int)

        var errorDescription: String? {
            switch self {
            case .noText:
                return "Please provide something to Tweet"
                
            case .textTooLong(let maxLength):
                return "Your Tweet cannot be longer than \(maxLength)"
            }
        }
    }
}
