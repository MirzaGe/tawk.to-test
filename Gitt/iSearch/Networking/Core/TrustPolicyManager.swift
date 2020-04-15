//
//  TrustPolicyManager.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Alamofire
import Foundation

/**
 The server trust policy to be used in Moya Manager.
 */
class TrustPolicyManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
    init() {
        super.init(policies: [:])
    }
}
