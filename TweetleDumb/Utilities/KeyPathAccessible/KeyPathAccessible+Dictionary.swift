//
//  KeyPathAccessible+Dictionary.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension Dictionary: KeyPathAccessible {
    func value<T>(at key: KeyPathComponent) throws -> T {
        guard let itemKey = key as? Key else { throw KeyPathError.invalid(key: [key]) }

        guard let value = self[itemKey] else { throw KeyPathError.missing(key: [key]) }

        guard let typedValue = value as? T
            else { throw KeyPathError.mismatch(key: [key], expected: T.self, found: type(of: value)) }

        return typedValue
    }

    func path(at key: KeyPathComponent) throws -> KeyPathAccessible {
        return try value(at: key)
    }
}

// Required to handle bridging
extension NSDictionary: KeyPathAccessible {
    func value<T>(at key: KeyPathComponent) throws -> T {
        return try (self as Dictionary).value(at: key)
    }
    func path(at key: KeyPathComponent) throws -> KeyPathAccessible {
        return try (self as Dictionary).path(at: key)
    }
}
