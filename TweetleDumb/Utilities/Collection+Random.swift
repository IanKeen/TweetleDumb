//
//  Collection+Random.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension Collection where Index == Int {
    func random() -> Iterator.Element? {
        guard !isEmpty else { return nil }

        let index = Int(arc4random() % UInt32(count))
        return self[index]
    }
}
