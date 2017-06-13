//
//  Result.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

/// Generic type representing the outcome of an operation
///
/// - success: A successful outcome with the associated value
/// - failure: An unsucessful output with the associated error
enum Result<T> {
    case success(T)
    case failure(Error)
}

//MARK: - Creation
extension Result {
    /// Create a successful result
    ///
    /// - Parameter value: Successful value
    init(_ value: T) {
        self = .success(value)
    }

    /// Create a failed result
    ///
    /// - Parameter error: Failure error
    init(_ error: Error) {
        self = .failure(error)
    }

    /// Creates a result from a closure that may succeed or fail
    ///
    /// - Parameter closure: Closure used to attempt to obtain result value
    init(_ closure: () throws -> T) {
        do { self = .success(try closure()) }
        catch let error { self = .failure(error) }
    }
}

//MARK: - Values
extension Result {
    /// Attempt to obtain the `T` from this `Result`
    ///
    /// - Returns: The `T` is this `Result` was successful
    /// - Throws: The `Error` if this `Result` failed
    func value() throws -> T {
        switch self {
        case .failure(let error): throw error
        case .success(let value): return value
        }
    }
}

//MARK: - State
extension Result {
    /// Returns `true` if the `Result` was successful, otherwise `false`
    var isSuccess: Bool {
        switch self {
        case .failure: return false
        case .success: return true
        }
    }

    /// Returns `true` if the `Result` failed, otherwise `true`
    var isFailure: Bool {
        switch self {
        case .failure: return true
        case .success: return false
        }
    }
}

//MARK: - Transformation
extension Result {
    /// Transforms a successful value from `T` to `U`
    ///
    /// - Parameter transform: Closure to attempt to transform `T` to `U`
    /// - Returns: A new `Result` with the updated type if successful, otherwise a failed `Result` with the reason
    func map<U>(_ transform: (T) throws -> U) -> Result<U> {
        return Result<U>({ try transform(try self.value()) })
    }

    /// Transforms a sucessful value from `T` into a new `Result<U>`
    ///
    /// - Parameter transform: Closure to attempt to transform `T` into a new `Result<U>`
    /// - Returns: A new `Result` if sucessful, otherwise a failed `Result` with the reason
    func flatMap<U>(_ transform: (T) throws -> Result<U>) -> Result<U> {
        do {
            return try transform(try self.value())
        } catch let error {
            return .failure(error)
        }
    }
}
