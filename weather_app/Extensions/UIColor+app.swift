//
//  UIColor+app.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation
import UIKit

extension UIColor {
    static let appBackground = UIColor(r: 238, g: 242, b: 249, a: 1)
    static let headerBackground = UIColor(r: 245, g: 247, b: 249, a: 1)
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
