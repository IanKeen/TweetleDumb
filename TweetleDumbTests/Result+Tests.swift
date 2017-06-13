//
//  Result+Tests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

extension Result {
    func assertSuccess() {
        XCTAssertTrue(self.isSuccess)
        XCTAssertFalse(self.isFailure)
    }
    func assertFailure() {
        XCTAssertTrue(self.isFailure)
        XCTAssertFalse(self.isSuccess)
    }
    func assertFailure<E: Error>(_ error: E) where E: Equatable {
        assertFailure()

        do {
            _ = try self.value()
        } catch let e as E {
            XCTAssertEqual(error, e)
        } catch {
            XCTFail()
        }
    }
}

extension Result where T: Equatable {
    func assertSuccess(_ value: T) {
        assertSuccess()

        switch self {
        case .failure: XCTFail()
        case .success(let v):
            XCTAssertEqual(v, value)
        }
    }
}
