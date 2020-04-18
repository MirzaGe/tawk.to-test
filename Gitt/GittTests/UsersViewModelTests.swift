//
//  UsersViewModelTests.swift
//  GittTests
//
//  Created by Glenn Von Posadas on 4/16/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import Gitt

class UsersViewModelTests: BaseUnitTests {
    func testMockDelegate() {
        XCTAssert(self.mockUsersDelegate.reloadDataWasCalled == true, "After viewModel init, the reload data must be called.")
    }
    
    func testSearchResult() {
        XCTAssertNotNil(self.usersViewModel.users, "Search result USERS object must not be nil.")
    }
    
    func testSearchResultData() {
        XCTAssertNotNil(self.usersViewModel.users, "Users object must not be nil.")
        XCTAssert(self.usersViewModel.users.count > 0, "Users object must be > 0.")
    }
    
    func testDidSelect() {
        self.usersViewModel.tableView(UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssert(self.mockUsersDelegate.showProfileWasCalled == true, "After viewModel init, the showProfile() must be called.")
    }
}
