//
//  AppConfig.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

/**
 Holds the configuration of the whole app.
 Such as the current region/country, global settings, and whatnot.
 */
struct AppConfig {
    
    // MARK: - Properties
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static var country: String {
        get {
            return "au"
        }
    }
    
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone

    // MARK: - Functions

}
