//
//  AppDelegate.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-12.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var applicationController: ApplicationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        applicationController = ApplicationController(
            environment: Environment(
                baseURL: URL(string: "https://api.tweetledumb.com")!,
                keyValueStore: UserDefaults.standard,
                authenticators: [
                    MockTwitterAuthenticator()
                ],
                network: MockNetwork()
            ),
            rootNavigationController: UINavigationController()
        )

        applicationController.start()

        return true
    }
}
