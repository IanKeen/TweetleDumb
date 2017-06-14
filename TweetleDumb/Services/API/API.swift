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
    private let authenticationState: ReadOnlyAuthenticationState

    // MARK: - Lifecycle
    init(network: Network, baseURL: URL, authenticationState: ReadOnlyAuthenticationState) {
        self.network = network
        self.baseURL = baseURL
        self.authenticationState = authenticationState
    }

    // MARK: - Public Functions
    func execute<T: APIRequest>(request: T, complete: @escaping (Result<T.Response>) -> Void) {
        do {
            let networkRequest = try buildNetworkRequest(from: request)

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

    // MARK: - Private Functions
    private func buildNetworkRequest<T: APIRequest>(from request: T) throws -> NetworkRequest {
        var networkRequest = try request.networkRequest(baseURL: baseURL)

        guard request.requiresAuthentication else { return networkRequest }

        guard let authentication = authenticationState.authentication
            else { throw AuthenticationController.Error.authenticationRequired }

        var headers = networkRequest.headers
        headers["token"] = authentication.token

        networkRequest.headers = headers
        return networkRequest
    }
}
