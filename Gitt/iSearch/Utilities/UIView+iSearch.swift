//
//  UIView+iSearch.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

/// A category for all views.
extension UIView {
    /// Helper for adding multiple subviews in a view.
    func addSubviews(_ views: UIView...) {
        views.forEach({self.addSubview($0)})
    }
    
    /// Generates a generic view with specic bg.
    static func new(backgroundColor: UIColor, alpha: CGFloat = 1.0, isHidden: Bool = false) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.alpha = alpha
        view.isHidden = isHidden
        return view
    }
    
    /// Adds a soft shadow at the back of the view.
    /// Useful for UILabel.
    func addSoftShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = false
    }
    
    /**
     Setups the layer of a view.
     - paramters:
     - shadowOffset: Controls the spread.
     - shadowRadius: Controls the blur
     */
    func setupLayer(
        cornerRadius: CGFloat = 22,
        borderWidth: CGFloat = 0,
        borderColor: UIColor = .clear,
        shadowOffSet: CGSize = CGSize(width: 0, height: 1),
        shadowColor: UIColor = UIColor(red:0, green:0, blue:0, alpha:0.15),
        shadowOpacity: Float = 1,
        shadowRadius: CGFloat = 2,
        shouldClipToBounds: Bool = false
    ) {
        
        self.layer.cornerRadius     = cornerRadius
        self.layer.borderWidth      = borderWidth
        self.layer.borderColor      = borderColor.cgColor
        self.layer.shadowOffset     = shadowOffSet
        self.layer.shadowColor      = shadowColor.cgColor
        self.layer.shadowOpacity    = shadowOpacity
        self.layer.shadowRadius     = shadowRadius
        self.clipsToBounds = shouldClipToBounds
    }
}
