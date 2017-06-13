//
//  NetworkResponseTests.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import XCTest
@testable import TweetleDumb

private let urlResponse = HTTPURLResponse(
    url: URL(string: "https://api.tweetledumb.com")!,
    mimeType: "application/json",
    expectedContentLength: -1,
    textEncodingName: nil
)

class NetworkResponseTests: XCTestCase {
    func testNetworkResponse_NoData() {
        let response = NetworkResponse(response: urlResponse, data: nil)

        XCTAssertNil(response.data)
        XCTAssertNil(response.jsonArray)
        XCTAssertNil(response.jsonDictionary)
        XCTAssertNil(response.string)
    }
    func testNetworkResponse_Dictionary() throws {
        let data: [String: String] = ["foo": "bar"]

        let response = NetworkResponse(
            response: urlResponse,
            data: try JSONSerialization.data(withJSONObject: data, options: [])
        )

        XCTAssertNotNil(response.data)
        XCTAssertNil(response.jsonArray)
        XCTAssertEqual(response.jsonDictionary as! [String: String], data)
        XCTAssertEqual(response.string, "{\"foo\":\"bar\"}")
    }
    func testNetworkResponse_Array() throws {
        let data: [String] = ["foo", "bar", "baz"]

        let response = NetworkResponse(
            response: urlResponse,
            data: try JSONSerialization.data(withJSONObject: data, options: [])
        )

        XCTAssertNotNil(response.data)
        XCTAssertEqual(response.jsonArray as! [String], data)
        XCTAssertNil(response.jsonDictionary)
        XCTAssertEqual(response.string, "[\"foo\",\"bar\",\"baz\"]")
    }
    func testNetworkResponse_String() {
        let response = NetworkResponse(
            response: urlResponse,
            data: "foobar".data(using: .utf8)!
        )

        XCTAssertNotNil(response.data)
        XCTAssertNil(response.jsonArray)
        XCTAssertNil(response.jsonDictionary)
        XCTAssertEqual(response.string, "foobar")
    }
}
