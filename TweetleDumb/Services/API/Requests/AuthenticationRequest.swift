//
//  AuthenticationRequest.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct AuthenticationRequest: APIRequest {
    let authenticator: String
    let token: String

    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        return NetworkRequest(
            method: .POST,
            url: baseURL.appendingPathComponent("/v1/authentication"),
            headers: [:],
            body: [
                "authenticator": authenticator,
                "token": token
            ]
        )
    }

    func handle(response: NetworkResponse) throws -> Authentication {
        guard
            let json = response.jsonDictionary,
            let token = json["token"] as? String,
            let user = json["user"] as? [String: Any]
            else { throw NetworkError.invalidResponse(response) }

        return Authentication(
            token: token,
            user: User(
                realName: try user.value(at: "real_name"),
                email: try user.value(at: "email"),
                handle: try user.value(at: "handle")
            )
        )
    }
}
