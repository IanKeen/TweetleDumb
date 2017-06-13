//
//  KeyPathAccessibleDictionaryTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

class KeyPathAccessibleDictionaryTests: XCTestCase {
    let input: [String: Any] = ["foo": [1,2], "bar": [3, 4], "baz": 5]

    func testKeyPathDictionary_Path_Fail() {
        XCTAssertThrows(
            error: KeyPathError.invalid(key: [0]),
            when: {
                _ = try input.path(at: 0)
            }
        )
        XCTAssertThrows(
            error: KeyPathError.missing(key: ["qux"]),
            when: {
                _ = try input.path(at: "qux")
            }
        )
        XCTAssertThrows(
            error: KeyPathError.mismatch(
                key: ["baz"],
                expected: KeyPathAccessible.self,
                found: Any.self
            ),
            when: {
                _ = try input.path(at: "baz")
            }
        )
    }
    func testKeyPathDictionary_Path_Success() throws {
        XCTAssertEqual(try input.path(at: "foo") as! [Int], [1,2])
    }

    func testKeyPathDictionary_Value_Fail() throws {
        XCTAssertThrows(
            error: KeyPathError.missing(key: ["qux"]),
            when: {
                _ = try input.value(at: "qux") as Any
            }
        )
    }
    func testKeyPathDictionary_Value_Success() throws {
        XCTAssertEqual(try input.path(at: "foo") as! [Int], [1,2])
        XCTAssertEqual(try input.path(at: "bar") as! [Int], [3,4])
    }
}
