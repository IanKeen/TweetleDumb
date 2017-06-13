//
//  TestCommon.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

enum TestError: Error, Equatable {
    case error
    
    static func ==(lhs: TestError, rhs: TestError) -> Bool {
        return true
    }
}
