//
//  UIView+Constraints.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-13.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

extension UIView {
    func center(in view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func fill(_ view: UIView) {
        leftAnchor.align(to: view.leftAnchor)
        rightAnchor.align(to: view.rightAnchor)
        topAnchor.align(to: view.topAnchor)
        bottomAnchor.align(to: view.bottomAnchor)
    }
}
extension NSLayoutDimension {
    func align(to anchor: NSLayoutDimension, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, multiplier: 1.0, constant: offset).isActive = true
    }
    func equal(to value: CGFloat) {
        constraint(equalToConstant: value).isActive = true
    }
}
extension NSLayoutXAxisAnchor {
    func align(to anchor: NSLayoutXAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
extension NSLayoutYAxisAnchor {
    func align(to anchor: NSLayoutYAxisAnchor, offset: CGFloat = 0.0) {
        constraint(equalTo: anchor, constant: offset).isActive = true
    }
}
