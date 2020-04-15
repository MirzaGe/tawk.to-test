//
//  SearchMasterUITests.swift
//  iSearchUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

/**
 Tests for the `SearchMasterViewController`.
 */
class SearchMasterUITests: BaseUITestCase {
    /// Check all views visibility
    func testAllViewsVisibility() {
        let largeTitle = app.staticTexts["Track List"]
        wait(forElement: largeTitle, timeout: 25)
        
        // Static Texts - Tabs
        XCTAssert(largeTitle.exists)
        XCTAssert(app.tabBars.buttons["Recents"].exists, "This tab must be existing")
        XCTAssert(app.tabBars.buttons["Downloads"].exists, "This tab must be existing")
        XCTAssert(app.tabBars.buttons["Search"].exists, "This tab must be existing")
        XCTAssert(app.tabBars.buttons["Featured"].exists, "This tab must be existing")
        XCTAssert(app.tabBars.buttons["More"].exists, "This tab must be existing")
    }
    
    /// Test pull to refresh.
    func testPullToRefresh() {
        let firstCell = app.staticTexts["Star Wars: The Rise of Skywalker"]
        let start = firstCell.coordinate(withNormalizedOffset: (CGVector(dx: 0, dy: 0)))
        let finish = firstCell.coordinate(withNormalizedOffset: (CGVector(dx: 0, dy: 6)))
        start.press(forDuration: 0, thenDragTo: finish)
        XCTAssert(firstCell.exists, "First cell Star Wars: The Rise of Skywalker must be existing")
    }
    
    func testShowDetail() {
        let firstCell = app.staticTexts["Star Wars: The Rise of Skywalker"]
        firstCell.tap()
        XCTAssert(app.staticTexts["Star Wars: The Rise of Skywalker"].exists, "The title of the tapped test cell must be existing in the detail screen.")
    }
}
