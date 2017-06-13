//
//  NetworkRequest.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension NetworkRequest {
    enum Method: String {
        case GET, PUT, PATCH, POST, DELETE
    }
}

struct NetworkRequest {
    // MARK: - Properties
    var method: Method
    var url: URL
    var headers: [String: LosslessStringConvertible]
    var body: DataRepresentable?

    // MARK: - Public
    func buildURLRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue

        for (key, value) in self.headers {
            request.addValue(value.description, forHTTPHeaderField: key)
        }

        request.httpBody = self.body?.makeData()

        return request
    }
}
