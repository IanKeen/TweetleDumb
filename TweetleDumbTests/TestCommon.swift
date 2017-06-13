//
//  TestCommon.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest

enum TestError: Error, Equatable {
    case error
    
    static func ==(lhs: TestError, rhs: TestError) -> Bool {
        return true
    }
}

func XCTAssertThrows<T: Error>(file: StaticString = #file, line: UInt = #line, error: T, when closure: () throws -> Void) {
    do {
        try closure()
        XCTFail(file: file, line: line)

    } catch let e as T {
        XCTAssertEqual(String(describing: error), String(describing: e), file: file, line: line)

    } catch {
        XCTFail(file: file, line: line)
    }
}
