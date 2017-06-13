//
//  User.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct User {
    let realName: String
    let email: String
    let handle: String
}

extension User {
    init(json: [String: Any]) throws {
        self.realName = try json.value(at: "real_name")
        self.email = try json.value(at: "email")
        self.handle = try json.value(at: "handle")
    }

    func makeDictionary() -> [String: Any] {
        return [
            "real_name": realName,
            "email": email,
            "handle": handle,
        ]
    }
}
