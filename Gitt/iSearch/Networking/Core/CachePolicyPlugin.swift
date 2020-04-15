//
//  CachePolicyPlugin.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Moya

/**
 Protocol to be used by Networking Services.
 */
protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

/**
 Cache policy plugin to be used by Networking Service Provider.
 # Example
    -  `let provider = MoyaProvider<Service>(plugins: [CachePolicyPlugin()])`
 */
final class CachePolicyPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            if let reachability = try? Reachability() {
                switch reachability.connection {
                case .wifi, .cellular:
                    mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
                default:
                    mutableRequest.cachePolicy = .returnCacheDataElseLoad
                }
            }
            
            mutableRequest.timeoutInterval = 10
            
            return mutableRequest
        }
        
        return request
    }
}

