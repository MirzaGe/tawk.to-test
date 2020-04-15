//
//  ResultHelperTests.swift
//  iSearchTests
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import iSearch

/**
 Tests `ResultHelper`
 */
class ResultHelperTests: BaseUnitTests {
    func testAllResultHelperVariables() {
        let data = self.selectedResult!
        XCTAssert(data.cellType == .long, "The cell type for movie (we are in movie type), must be .long")
        XCTAssert(data.dateLabelIsHidden == false, "The date label is not hidden in movie type!")
        XCTAssert(data.currencySymbol == "$", "The first data in stubbed response is dollars so the helper must provide $ in currencySymbole!")
        XCTAssert(data.titlePresentable == "Star Wars: The Rise of Skywalker", "The title presentable is the first stubbed response data")
        
        // Continue mroe test cases here...
    }
}
