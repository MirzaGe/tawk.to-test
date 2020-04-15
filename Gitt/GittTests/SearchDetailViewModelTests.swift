//
//  SearchDetailViewModelTests.swift
//  iSearchTests
//
//  Created by Glenn Von Posadas on 4/11/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import XCTest
@testable import iSearch

class SearchDetailViewModelTests: BaseUnitTests {
    func testSelectedResult() {
        XCTAssert(self.searchDetailViewModel.selectedResult != nil, "the selected result object must not be nil!")
    }
    
    func testPresentableBehaviorRelays() {
        let vm = self.searchDetailViewModel!
        
        // No need for assert messages, see detail UI tests or result helper tests.
        XCTAssert(vm.trackTitlePresentable.value == "Star Wars: The Rise of Skywalker")
        XCTAssert(vm.contentRatingPresentable.value == " M ")
        XCTAssert(vm.genreDatePresentable.value == "Action & Adventure • 2019")
        XCTAssert(vm.buyButtonTitlePresentable.value == "$ 19.99 BUY")
        XCTAssert(vm.rentButtonTitlePresentable.value == "$ 5.99 RENT")
        
        let searchAboutTheMovieValue = "In STAR WARS: THE RISE OF SKYWALKER, the riveting conclusion of the landmark Skywalker saga, new legends will be born—and the final battle for freedom is yet to come. WARNING: SOME FLASHING-LIGHTS SCENES IN THIS FILM MAY AFFECT PHOTOSENSITIVE VIEWERS"
        XCTAssert(vm.aboutPresentable.value == searchAboutTheMovieValue)
        
        XCTAssert(vm.artworkResource.value != nil)
    }
}
