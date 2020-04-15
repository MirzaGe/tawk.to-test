//
//  GetButton.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

/**
 The button used in `DataTableViewCell`.
 */
class GetButton: BaseButton {

    // MARK: - Properties
    
    var shouldHighlight: Bool = true
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                self.alpha = self.shouldHighlight ? 0.6 : 1.0
            }
            else {
                self.alpha = 1.0
            }
            super.isHighlighted = newValue
        }
    }

    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set {
            if newValue {
                self.alpha = self.shouldHighlight ? 0.6 : 1.0
            }
            else {
                self.alpha = 1.0
            }
            super.isSelected = newValue
        }
    }
    
    // MARK: - Functions
    // MARK: Overrides
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius     = 4.0
        self.layer.borderWidth      = 1.0
        self.layer.borderColor      = UIColor.systemBlue.cgColor
        self.backgroundColor        = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
