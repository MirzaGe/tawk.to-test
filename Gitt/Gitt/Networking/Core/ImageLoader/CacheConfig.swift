//
//  CacheConfig.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/16/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

struct CacheConfig {
    let countLimit: Int
    let memoryLimit: Int

    static let defaultConfig = CacheConfig(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
}
