//
//  MulticastDelegate.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

final class MulticastDelegate<T> {
    // MARK: - Private Properties
    private var delegates: [AnyObject] = []

    // MARK: - Lifecycle
    deinit {
        removeAll()
    }

    // MARK: - Public Functions
    func add(_ delegate: T) {
        delegates.append(delegate as AnyObject)
    }
    func remove(_ delegate: T) {
        guard let index = delegates.index(where: { $0 === (delegate as AnyObject) }) else { return }

        delegates.remove(at: index)
    }
    func removeAll() {
        delegates.removeAll()
    }
    func notify(_ closure: (T) -> Void) {
        delegates.map({ $0 as! T }).forEach(closure)
    }
}
