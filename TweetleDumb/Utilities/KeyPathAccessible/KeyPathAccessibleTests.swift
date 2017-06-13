//
//  KeyPathAccessibleTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

class KeyPathAccessibleTests: XCTestCase {
    let input: [String: Any] = ["foo": [1,2], "bar": ["baz": [3,4]]]

    func testKeyPathAccessible_Chain_Fail() {
        XCTAssertThrows(
            error: KeyPathError.missing(key: [2]),
            when: {
                _ = try input.path(at: "foo").value(at: 2) as Int
            }
        )
        XCTAssertThrows(
            error: KeyPathError.missing(key: [2]),
            when: {
                _ = try input
                    .path(at: "bar")
                    .path(at: "baz")
                    .value(at: 2) as Int
            }
        )
    }
    func testKeyPathAccessible_Chain_Success() {
        XCTAssertEqual(try input.path(at: "foo").value(at: 1), 2)
        XCTAssertEqual(try input.path(at: "bar").path(at: "baz").value(at: 0), 3)
    }
}
