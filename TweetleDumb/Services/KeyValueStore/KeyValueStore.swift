//
//  KeyValueStore.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol KeyValueStore {
    func get<T>(key: String) -> T?
    func set<T>(value: T, forKey key: String)
    func remove(key: String)
}

extension UserDefaults: KeyValueStore {
    func get<T>(key: String) -> T? {
        return object(forKey: key) as? T
    }
    func set<T>(value: T, forKey key: String) {
        set(value, forKey: key)
    }
    func remove(key: String) {
        removeObject(forKey: key)
    }
}
