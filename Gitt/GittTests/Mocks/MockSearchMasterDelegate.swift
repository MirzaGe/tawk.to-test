//
//  MockSearchMasterDelegate.swift
//  iSearchTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import iSearch

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
