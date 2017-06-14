//
//  KeyboardObserver.swift
//  TweetleDumb
//
//  Created by Ian Keen on 2017-06-14.
//  Copyright © 2017 Mustard. All rights reserved.
//

import UIKit

final class KeyboardObserver {
    // MARK: - Private Properties
    private let container: UIView
    private var observers: [Any] = []
    private let originalHeight: CGFloat

    init(container: UIView) {
        self.container = container
        originalHeight = container.frame.height
    }
    deinit { stop() }

    // MARK: - Public Functions
    func start() {
        let notifications: [Notification.Name] = [.UIKeyboardWillShow, .UIKeyboardWillHide]
        observers = notifications.map(subscribe(to:))
    }
    func stop() {
        observers.forEach(NotificationCenter.default.removeObserver)
    }

    // MARK: - Private Functions
    private func subscribe(to notification: Notification.Name) -> Any {
        return NotificationCenter.default.addObserver(forName: notification, object: nil, queue: .main) { [weak self] obj in
            guard let this = self else { return }

            let offset = this.offset(from: obj)
            let duration = this.duration(from: obj)

            UIView.animate(withDuration: duration, delay: 0.0, options: .layoutSubviews, animations: {
                this.container.frame = CGRect(
                    x: this.container.frame.origin.x,
                    y: this.container.frame.origin.y,
                    width: this.container.frame.size.width,
                    height: (notification == .UIKeyboardWillHide) ? this.originalHeight : this.container.frame.size.height + offset
                )
            })
        }
    }
    private func offset(from notification: Notification) -> CGFloat {
        guard
            let userInfo = notification.userInfo,
            let begin = userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue,
            let end = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue
            else { return .leastNormalMagnitude }

        return end.cgRectValue.minY - begin.cgRectValue.minY
    }
    private func duration(from notification: Notification) -> TimeInterval {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return 0 }

        return duration
    }
}
