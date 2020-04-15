//
//  BaseUnitTests.swift
//  iSearchTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import iSearch

class BaseUnitTests: XCTestCase {

    // MARK: - Properties
    
    var searchMasterViewModel: SearchMasterViewModel!
    var mockSearchMasterDelegate: MockSearchMasterDelegate!
    
    var searchDetailViewModel: SearchDetailViewModel!
    var mockSearchDetailDelegate: MockSearchDetailDelegate!
    
    var selectedResult: Result!
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func setUp() {
        self.mockSearchMasterDelegate = MockSearchMasterDelegate()
        self.searchMasterViewModel = SearchMasterViewModel(searchMasterController: self.mockSearchMasterDelegate)
        
        self.selectedResult = self.searchMasterViewModel.searchResult?.results?.first
        
        self.mockSearchDetailDelegate = MockSearchDetailDelegate()
        self.searchDetailViewModel = SearchDetailViewModel(
            searchDetailController: self.mockSearchDetailDelegate,
            selectedResult: self.selectedResult
        )
    }
}
