//
//  extensions.swift
//  TODO
//
//  Created by Wojtek Rempiński on 28/05/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        let chars = Array(hex.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)}
}
