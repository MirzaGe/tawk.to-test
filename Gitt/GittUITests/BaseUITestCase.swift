//
//  BaseUITestCase.swift
//  GittUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

class BaseUITestCase: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        // We send a command line argument to our app,
        // to enable it to reset its state.
        app.launchArguments.append("--uitesting")
        app.launchEnvironment = ["unitUITest" : "true"]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        
        app.terminate()
    }
}
