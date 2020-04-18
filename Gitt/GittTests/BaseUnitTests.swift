//
//  BaseUnitTests.swift
//  GittTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import Gitt

class BaseUnitTests: XCTestCase {

    // MARK: - Properties
    
    var usersViewModel: UsersViewModel!
    var mockUsersDelegate: MockUsersDelegate!
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func setUp() {
        self.mockUsersDelegate = MockUsersDelegate()
        self.usersViewModel = UsersViewModel(usersController: self.mockUsersDelegate)
    }
}
