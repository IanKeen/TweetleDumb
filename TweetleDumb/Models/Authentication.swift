//
//  Authentication.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct Authentication {
    let token: String
    let user: User
}

extension Authentication {
    init(json: [String: Any]) throws {
        self.token = try json.value(at: "token")
        self.user = try User(json: try json.value(at: "user"))
    }

    func makeDictionary() -> [String: Any] {
        return [
            "token": token,
            "user": user.makeDictionary()
        ]
    }
}
