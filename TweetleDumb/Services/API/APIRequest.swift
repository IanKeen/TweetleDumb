//
//  APIRequest.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol APIRequest {
    associatedtype Response

    func networkRequest(baseURL: URL) throws -> NetworkRequest

    func handle(response: NetworkResponse) throws -> Response
}
