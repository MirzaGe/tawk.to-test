//
//  MockSearchMasterDelegate.swift
//  GittTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import Gitt

class MockSearchMasterDelegate: NSObject, SearchMasterDelegate {
    var showDetailWasCalled: Bool = false
    var reloadDataWasCalled: Bool = false
    
    func showDetail(with result: Result) {
        self.showDetailWasCalled = true
    }
    
    func reloadData() {
        self.reloadDataWasCalled = true
    }
}
