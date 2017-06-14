//
//  UINavigationController+ShouldAnimate.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

extension UINavigationController {
    var shouldAnimate: Bool { return !self.viewControllers.isEmpty }
}
