//
//  SearchResult.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    
    // MARK: - Properties
    
    let resultCount: Int?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case results = "results"
    }
}
