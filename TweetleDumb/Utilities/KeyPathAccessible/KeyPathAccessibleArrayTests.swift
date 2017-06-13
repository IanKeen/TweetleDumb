//
//  KeyPathAccessibleArrayTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

class KeyPathAccessibleArrayTests: XCTestCase {
    func testKeyPathArray_Path_Fail() {
        let input = [1,2,3]

        XCTAssertThrows(
            error: KeyPathError.invalid(key: ["0"]),
            when: {
                _ = try input.path(at: "0")
            }
        )
        XCTAssertThrows(
            error: KeyPathError.missing(key: [5]),
            when: {
                _ = try input.path(at: 5)
            }
        )
        XCTAssertThrows(
            error: KeyPathError.mismatch(
                key: [0],
                expected: KeyPathAccessible.self,
                found: Int.self
            ),
            when: {
                _ = try input.path(at: 0)
            }
        )
    }
    func testKeyPathArray_Path_Success() throws {
        let input = [[1, 2], [3, 4]]

        XCTAssertEqual(try input.path(at: 0) as! [Int], [1,2])
    }

    func testKeyPathArray_Value_Fail() throws {
        let input = [1,2,3]

        XCTAssertThrows(
            error: KeyPathError.missing(key: [4]),
            when: {
                _ = try input.value(at: 4) as Int
            }
        )
    }
    func testKeyPathArray_Value_Success() throws {
        let input = [1,2,3]

        XCTAssertEqual(try input.value(at: 0), 1)
        XCTAssertEqual(try input.value(at: 1), 2)
        XCTAssertEqual(try input.value(at: 2), 3)
    }
}
