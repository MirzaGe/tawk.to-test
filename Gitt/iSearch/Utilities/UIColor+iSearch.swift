//
//  UIColor+iSearch.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

extension UIColor {
    /// Color mainly used for error internet notifier
    static let iSearchErrorRed: UIColor = UIColor.colorWithRGBHex(0xff3f34)
    /// Color used for texts to support dark mode, such as large title
    static let textColor: UIColor = UIColor(named: "TextColor")!
    /// Color used for background of views.
    static let backgroundColor: UIColor = UIColor(named: "BackgroundColor")!
    
    /// Hex to UIColor.
    class func colorWithRGBHex(_ hex: Int, alpha: Float = 1.0) -> UIColor {
        let r = Float((hex >> 16) & 0xFF)
        let g = Float((hex >> 8) & 0xFF)
        let b = Float((hex) & 0xFF)
        
        return UIColor(red: CGFloat(r / 255.0), green: CGFloat(g / 255.0), blue:CGFloat(b / 255.0), alpha: CGFloat(alpha))
    }
}
