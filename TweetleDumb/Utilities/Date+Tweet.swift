//
//  Date+Tweet.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

enum DateFormatterError: LocalizedError {
    case invalidDateString

    var errorDescription: String? {
        switch self {
        case .invalidDateString:
            return "Invalid date string"
        }
    }
}

extension Date {
    private static let tweetDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter
    }()

    init(string: String) throws {
        guard let date = Date.tweetDateFormatter.date(from: string)
            else { throw DateFormatterError.invalidDateString }

        self = date
    }
}
