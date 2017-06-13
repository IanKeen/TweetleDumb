//
//  Authenticator.swift
//  TweedleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

/// Represents an external means of authentication
/// i.e. Twitter, and returns the token that will be passed
/// to the applications backend for authentication.
protocol Authenticator {
    var name: String { get }
    
    func login(complete: @escaping (Result<String>) -> Void)
    func logout()
}
