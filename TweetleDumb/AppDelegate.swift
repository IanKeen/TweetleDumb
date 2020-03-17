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
    var applicationCoordinator: ApplicationCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let navigationController = UINavigationController()

        applicationCoordinator = ApplicationCoordinator(
            environment: Environment(
                baseURL: URL(string: "https://api.tweetledumb.com")!,
                keyValueStore: UserDefaults.standard,
                authenticators: [
                    MockTwitterAuthenticator()
                ],
                network: MockNetwork()
            ),
            rootNavigationController: navigationController
        )

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        self.window = window

        applicationCoordinator.start()

        window.makeKeyAndVisible()
        return true
    }
}
