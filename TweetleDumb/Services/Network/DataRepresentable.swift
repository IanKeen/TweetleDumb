//
//  DataRepresentable.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol DataRepresentable {
    func makeData() -> Data?
}

extension DataRepresentable {
    var string: String {
        guard let data = self.makeData() else { return "" }
        return String(data: data, encoding: .utf8) ?? ""
    }
}

extension Data: DataRepresentable {
    func makeData() -> Data? {
        return self
    }
}

extension Dictionary: DataRepresentable {
    func makeData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
