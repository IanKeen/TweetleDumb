//
//  API.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

/// API provides the domain/business specific logic on top of `Network`
final class API {
    // MARK: - Private Properties
    private let network: Network
    private let baseURL: URL

    // MARK: - Lifecycle
    init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
    }

    // MARK: - Public Functions
    func execute<T: APIRequest>(request: T, complete: @escaping (Result<T.Response>) -> Void) {
        do {
            let networkRequest = try request.networkRequest(baseURL: baseURL)

            network.perform(
                request: networkRequest,
                complete: { response in
                    let result = response.map { try request.handle(response: $0) }
                    complete(result)
                }
            )

        } catch let error {
            complete(.failure(error))
        }
    }
}
