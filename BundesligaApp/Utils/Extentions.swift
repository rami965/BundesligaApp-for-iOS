//
//  Extentions.swift
//  BundesligaApp
//
//  Created by MACC on 2/3/18.
//  Copyright © 2018 Rami. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}
