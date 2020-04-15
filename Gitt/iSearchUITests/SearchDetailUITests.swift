//
//  SearchDetailUITests.swift
//  iSearchUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

/**
 Tests for the `SearchDetailViewController`.
 */
class SearchDetailUITests: BaseUITestCase {
    /// Check all views visibility, including price buttons
    func testAllViewsVisibility() {
        let largeTitle = app.staticTexts["Track List"]
        wait(forElement: largeTitle, timeout: 25)
        
        let firstCell = app.staticTexts["Star Wars: The Rise of Skywalker"]
        firstCell.tap()
        
        XCTAssert(app.staticTexts["Star Wars: The Rise of Skywalker"].exists, "The title of the tapped test cell must be existing in the detail screen.")
        XCTAssert(app.staticTexts[" M "].exists, "Rating must exist.")
        XCTAssert(app.staticTexts["Action & Adventure • 2019"].exists, "Genre and Year released must exist.")
        XCTAssert(app.staticTexts["$ 19.99 BUY"].exists, "Buy button must exist.")
        XCTAssert(app.staticTexts["$ 5.99 RENT"].exists, "Rent button must exist.")
        XCTAssert(app.staticTexts["About the Movie"].exists, "About the movie label must exist.")
        
        let searchAboutTheMovieValue = "In STAR WARS: THE RISE OF SKYWALKER, the riveting conclusion of the landmark Skywalker saga, new legends will be born—and the final battle for freedom is yet to come. WARNING: SOME FLASHING-LIGHTS SCENES IN THIS FILM MAY AFFECT PHOTOSENSITIVE VIEWERS"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", searchAboutTheMovieValue)
        let elementQuery = app.staticTexts.containing(predicate)
        
        XCTAssert(elementQuery.count > 0, "About the movie label value must exist.")
    }
}
