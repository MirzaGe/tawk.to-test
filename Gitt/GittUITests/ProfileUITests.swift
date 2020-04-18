//
//  ProfileUITests.swift
//  GittUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

/**
 Tests for the `SearchDetailViewController`.
 */
class ProfileUITests: BaseUITestCase {
    /// Check all views visibility, including price buttons
    func testAllViewsVisibility() {
        let largeTitleForFirstScreen = app.staticTexts["Users"]
        wait(forElement: largeTitleForFirstScreen, timeout: 10)

        let firstCell = app.staticTexts["mojombo"]
        firstCell.tap()
        
        let navBarTitle = app.staticTexts["Tom Preston-Werner"]
        wait(forElement: navBarTitle, timeout: 10)

        XCTAssert(app.staticTexts["Save"].exists, "Save button must be existing.")
        XCTAssert(app.staticTexts["Company: "].exists, "Company label must be existing.")
        XCTAssert(app.staticTexts["Following: 11"].exists, "Following labels must be existing.")
        XCTAssert(app.staticTexts["Followers: 21917"].exists, "Followers labels must be existing.")
    }
}
