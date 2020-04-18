//
//  MockUsersDelegate.swift
//  GittTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import Gitt

class MockUsersDelegate: NSObject, UsersDelegate {
    var showProfileWasCalled: Bool = false
    var reloadDataWasCalled: Bool = false
    
    func showProfile(for user: User) {
        self.showProfileWasCalled = true
    }
    
    func reloadData() {
        self.reloadDataWasCalled = true
    }
}
