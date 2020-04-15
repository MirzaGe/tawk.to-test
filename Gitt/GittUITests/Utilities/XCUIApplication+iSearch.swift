//
//  XCUIApplication+iSearch.swift
//  iSearchUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

extension XCUIApplication {
    func staticTextExists(_ text: String) -> Bool {
        return self.staticTexts[text].exists
    }
    
    func textFieldExists(_ identifier: String) -> Bool {
        return self.textFields[identifier].exists
    }
    
    func secureTextFieldExists(_ identifier: String) -> Bool {
        return self.secureTextFields[identifier].exists
    }
    
    func buttonExists(_ identifier: String) -> Bool {
        return self.buttons[identifier].exists
    }
}
