//
//  Network.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse(NetworkResponse)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Received an unexpected response"
        }
    }
}

/// Represents the network layer
protocol Network {
    typealias RequestComplete = (Result<NetworkResponse>) -> Void

    /// Perform a request
    ///
    /// - Parameters:
    ///   - request: The `NetworkRequest` to perform
    ///   - complete: The closure that is called upon completion of the network request.
    func perform(request: NetworkRequest, complete: @escaping RequestComplete)
}
