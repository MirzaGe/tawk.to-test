//
//  UsersUITests.swift
//  GittUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

/**
 Tests for the `UsersViewController`.
 */
class UsersUITests: BaseUITestCase {
    /// Check all views visibility
    func testAllViewsVisibility() {
        let largeTitle = app.staticTexts["Users"]
        wait(forElement: largeTitle, timeout: 10)
        
        // Static Texts - Tabs
        XCTAssert(largeTitle.exists)
        XCTAssert(app.searchFields["Search"].exists, "The search bar must be existing")
        XCTAssert(app.staticTextExists("mojombo"), "The mojombo first user must be existing since we are using stubbed reponse!")
        XCTAssert(app.staticTextExists("userId: 1"), "The id of the first user must be existing since we are using stubbed reponse!")
    }
    
    /// Test pull to refresh.
    func testPullToRefresh() {
        let largeTitle = app.staticTexts["Users"]
        wait(forElement: largeTitle, timeout: 10)
        
        let firstCell = app.staticTexts["mojombo"]
        let start = firstCell.coordinate(withNormalizedOffset: (CGVector(dx: 0, dy: 0)))
        let finish = firstCell.coordinate(withNormalizedOffset: (CGVector(dx: 0, dy: 6)))
        start.press(forDuration: 1, thenDragTo: finish)
        XCTAssert(firstCell.exists, "mojombo must still be existing after pull-to-refresh")
    }
    
    func testShowDetail() {
        let largeTitle = app.staticTexts["Users"]
        wait(forElement: largeTitle, timeout: 10)
        
        let firstCell = app.staticTexts["mojombo"]
        firstCell.tap()
        XCTAssert(app.staticTexts["Tom Preston-Werner"].exists, "The title of the tapped test cell must be existing in the profile screen.")
    }
}
