//
//  SearchMasterViewModelTests.swift
//  iSearchTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import iSearch

class SearchMasterViewModelTests: BaseUnitTests {
    func testMockDelegate() {
        XCTAssert(self.mockSearchMasterDelegate.reloadDataWasCalled == true, "After viewModel init, the reload data must be called.")
    }
    
    func testSearchResult() {
        XCTAssertNotNil(self.searchMasterViewModel.searchResult, "Search result object must not be nil.")
    }
    
    func testSearchResultData() {
        XCTAssertNotNil(self.searchMasterViewModel.searchResult?.results, "Results object must not be nil.")
        XCTAssert(self.searchMasterViewModel.searchResult!.results!.count > 0, "Results object must be > 0.")
    }
    
    func testDidSelect() {
        self.searchMasterViewModel.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(self.mockSearchMasterDelegate.showDetailWasCalled == true, "After viewModel init, the showDetail() must be called.")
        
        let storedDefaultsObject = AppDefaults.getObjectWithKey(.lastViewedResult, type: Result.self)
        XCTAssertNotNil(storedDefaultsObject, "after didSelect, there must be a stored object in the defaults with key lastViewedResult")
    }
}
