//
//  AuthenticationController+Error.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

extension AuthenticationController {
    enum Error: LocalizedError {
        case unsupportedAuthenticator
        case alreadyLoggedIn
        case alreadyLoggedOut
        case authenticationRequired

        var errorDescription: String? {
            switch self {
            case .unsupportedAuthenticator:
                return "Unimplemented authentication method"
            case .alreadyLoggedIn:
                return "You are already logged in"
            case .alreadyLoggedOut:
                return "You are already logged out"
            case .authenticationRequired:
                return "You need to be logged in to perform this action"
            }
        }
    }
}
