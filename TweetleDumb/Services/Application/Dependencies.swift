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
protocol HasAuthenticationState {
    var authenticationState: AuthenticationState { get }
}
protocol HasReadOnlyAuthenticationState {
    var readOnlyAuthenticationState: ReadOnlyAuthenticationState { get }
}
extension HasReadOnlyAuthenticationState where Self: HasAuthenticationState {
    var readOnlyAuthenticationState: ReadOnlyAuthenticationState { return self.authenticationState }
}
protocol HasAPI {
    var api: API { get }
}

extension ApplicationController: HasAuthenticationController { }
extension ApplicationController: HasAuthenticationState { }
extension ApplicationController: HasReadOnlyAuthenticationState { }
extension ApplicationController: HasAPI { }
