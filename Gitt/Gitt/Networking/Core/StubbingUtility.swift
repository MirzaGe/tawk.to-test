//
//  StubbingUtility.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/18/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

struct StubbingUtility {
    /// Helper function for providing file stubbed response.
    static func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
