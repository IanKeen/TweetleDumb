//
//  Environment.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

struct Environment {
    let baseURL: URL
    let keyValueStore: KeyValueStore
    let authenticators: [Authenticator]
    let network: Network
}
