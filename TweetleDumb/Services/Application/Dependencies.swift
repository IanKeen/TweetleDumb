//
//  Dependencies.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import Foundation

protocol HasAuthenticationController {
    var authenticationController: AuthenticationController { get }
}
protocol HasAPI {
    var api: API { get }
}

extension ApplicationController: HasAuthenticationController { }
extension ApplicationController: HasAPI { }
