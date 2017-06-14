//
//  Tweet.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct Tweet {
    let id: Int
    let text: String
    let posted: Date
    let user: User
}

extension Tweet {
    init(json: [String: Any]) throws {
        self.id = try json.value(at: "id")
        self.text = try json.value(at: "text")
        self.posted = try Date(string: try json.value(at: "posted"))
        self.user = try User(json: try json.value(at: "user"))
    }

    func makeDictionary() -> [String: Any] {
        return [
            "id": id,
            "text": text,
            "posted": posted.jsonString(),
            "user": user.makeDictionary()
        ]
    }
}
