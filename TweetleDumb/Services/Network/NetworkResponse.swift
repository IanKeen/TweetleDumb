//
//  NetworkResponse.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct NetworkResponse {
    let response: HTTPURLResponse
    let data: Data?
}

// MARK: - Conversions
extension NetworkResponse {
    var jsonDictionary: [String: Any]? {
        guard let data = self.data else { return nil }

        do { return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] }
        catch { return nil }
    }
    var jsonArray: [Any]? {
        guard let data = self.data else { return nil }

        do { return try JSONSerialization.jsonObject(with: data, options: []) as? [Any] }
        catch { return nil }
    }
    var string: String? {
        guard
            let data = self.data,
            let value = String(data: data, encoding: .utf8),
            !value.isEmpty
            else { return nil }

        return value
    }
}
