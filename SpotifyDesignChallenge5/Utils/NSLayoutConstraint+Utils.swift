//
//  NSLayoutConstraint+Utils.swift
//  SpotifyDesignChallenge5
//
//  Created by Edwin Cardenas on 3/25/23.
//

import UIKit

extension NSLayoutConstraint {
    @objc func setActiveBreakable(priority: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = priority
        isActive = true
    }
}
