//
//  XCTestCase+iSearch.swift
//  iSearchUITests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest

extension XCTestCase {
    func wait(forElement element: XCUIElement, timeout: TimeInterval, file: String = #file, line: UInt = #line) {
        let predicate = NSPredicate(format: "exists == 1")

        // This will make the test runner continuously evaluate the
        // predicate, and wait until it matches.
        expectation(for: predicate, evaluatedWith: element)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
}
