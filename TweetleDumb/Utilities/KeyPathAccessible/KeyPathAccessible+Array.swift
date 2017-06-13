//
//  KeyPathAccessible+Array.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension Array: KeyPathAccessible {
    func value<T>(at key: KeyPathComponent) throws -> T {
        guard let itemKey = key as? Index else { throw KeyPathError.invalid(key: [key]) }

        guard itemKey >= startIndex && itemKey < endIndex else { throw KeyPathError.missing(key: [key]) }

        let value = self[itemKey]
        guard let typedValue = value as? T
            else { throw KeyPathError.mismatch(key: [key], expected: T.self, found: type(of: value)) }

        return typedValue
    }
    func path(at key: KeyPathComponent) throws -> KeyPathAccessible {
        return try value(at: key)
    }
}

// Required to handle bridging
extension NSArray: KeyPathAccessible {
    func value<T>(at key: KeyPathComponent) throws -> T {
        return try (self as Array).value(at: key)
    }
    func path(at key: KeyPathComponent) throws -> KeyPathAccessible {
        return try (self as Array).path(at: key)
    }
}
