//
//  CoreService.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Moya

/// The core class of iSearch  networking. Contains constants.
struct CoreService {
    
    // MARK: - Properties
    
    /// Determines if each managers call the API verbosely.
    static var verbose: Bool = false
    
    /// Moya Manager
    static let moyaManager = Manager(
        configuration: URLSessionConfiguration.default,
        serverTrustPolicyManager: TrustPolicyManager()
    )

    /// For future use.
    static let deviceUUID = UIDevice.current.identifierForVendor!.uuidString

    /// Returns the base url of the API based on the environments.
    static let baseURLString = URL(string: "https://itunes.apple.com")!

    // MARK: - Functions
    
    /// Return moya providers based on environment.
    static func moyaProvider<T: TargetType>(target: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(
            manager: moyaManager,
            plugins: [NetworkLoggerPlugin(verbose: verbose), CachePolicyPlugin()]
        )
    }
    
    /// Helper function for providing file stubbed response.
    static func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}

