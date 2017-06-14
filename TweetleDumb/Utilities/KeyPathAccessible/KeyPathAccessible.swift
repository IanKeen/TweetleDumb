//
//  KeyPathAccessible.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

enum KeyPathError: LocalizedError {
    case invalid(key: [KeyPathComponent])
    case missing(key: [KeyPathComponent])
    case mismatch(key: [KeyPathComponent], expected: Any.Type, found: Any.Type)

    var errorDescription: String? {
        switch self {
        case .invalid(let keyPath):
            return "Invalid keyPath provided: '\(keyPath)'"
        case .missing(let keyPath):
            return "KeyPath not found at: '\(keyPath)'"
        case .mismatch(let keyPath, let expected, let found):
            return "Type mismatch at: '\(keyPath)' - Expected: \(expected), found: \(found)"
        }
    }
}

protocol KeyPathAccessible {
    func value<T>(at key: KeyPathComponent) throws -> T
    func path(at key: KeyPathComponent) throws -> KeyPathAccessible
}
