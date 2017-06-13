//
//  ResultTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

class ResultTests: XCTestCase {
    //MARK: - Init
    func testResult_InitValue() {
        let result = Result<Int>(42)
        result.assertSuccess(42)
    }
    func testResult_InitError() {
        let result = Result<Int>(TestError.error)
        result.assertFailure(TestError.error)
    }
    func testResult_InitClosure_Value() {
        let result = Result<Int>({ 42 })
        result.assertSuccess(42)
    }
    func testResult_InitClosure_Error() {
        let result = Result<Int>({ throw TestError.error })
        result.assertFailure(TestError.error)
    }

    //MARK: - Map
    func testResult_Map_Value() {
        let result = Result<Int>(42).map { String($0 * 2) }
        result.assertSuccess("84")
    }
    func testResult_Map_Throws() {
        let result = Result<Int>(42)
        result.assertSuccess(42)

        let map = result.map { _ in throw TestError.error }
        map.assertFailure(TestError.error)
    }
    func testResult_Map_AlreadyFailed() {
        let result = Result<Int>({ throw TestError.error })
        result.assertFailure(TestError.error)

        let map = result.map { $0 + 1 }
        map.assertFailure(TestError.error)
    }

    //MARK: - FlatMap
    func testResult_FlatMap_Value() {
        let result = Result<Int>(42)
        result.assertSuccess(42)

        let flatMap = result.flatMap { .success(String($0 * 2)) }
        flatMap.assertSuccess("84")
    }
    func testResult_FlatMap_Throws() {
        let result = Result<Int>(42)
        result.assertSuccess(42)

        let flatMap = result.flatMap { _ -> Result<String> in throw TestError.error }
        flatMap.assertFailure(TestError.error)
    }
    func testResult_FlatMap_AlreadyFailed() {
        let result = Result<Int>({ throw TestError.error })
        result.assertFailure(TestError.error)

        let flatMap = result.flatMap { .success(String($0 * 2)) }
        flatMap.assertFailure(TestError.error)
    }
}

