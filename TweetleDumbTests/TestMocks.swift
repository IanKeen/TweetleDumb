//
//  TestMocks.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

func api() -> API {
    return API(
        network: MockNetwork(randomErrors: false, delay: 0),
        baseURL: URL(string: "https://api.tweetledumb.com")!
    )
}

func authenticationStorage() -> KeyValueStore {
    return NSMutableDictionary(dictionary: [
        AuthenticationController.StorageKey.authentication:
            Authentication(
                token: "test",
                user: User(
                    realName: "Ian Keen",
                    email: "iankeen82@gmail.com",
                    handle: "@IanKay"
                )
            ).makeDictionary()
        ]
    )
}

extension NSMutableDictionary: KeyValueStore {
    public func get<T>(key: String) -> T? {
        return object(forKey: key) as? T
    }
    public func set<T>(value: T, forKey key: String) {
        setObject(value, forKey: key as NSString)
    }
    public func remove(key: String) {
        removeObject(forKey: key)
    }
}
