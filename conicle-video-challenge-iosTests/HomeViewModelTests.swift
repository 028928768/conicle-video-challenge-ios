//
//  HomeViewModelTests.swift
//  conicle-video-challenge-iosTests
//
//  Created by Simon SIwell on 16/6/2568 BE.
//

import XCTest
@testable import conicle_video_challenge_ios

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    // check if count function match total HomeOptions case
    func testOptionCountMatchesAllCases() {
        XCTAssertEqual(viewModel.count, HomeOption.allCases.count)
    }
    
    // check if get option from index function work by fetching and comparing it with firstOption
    func testOptionAtIndexReturnCorectCase() {
        let firstOption = viewModel.option(at: 0)
        XCTAssertEqual(firstOption, HomeOption.allCases[0])
    }
    
    func testOptionAtIndexDoesNotExist() {
        // try fetching out of bound index - should not return anything
        XCTAssertNil(viewModel.option(at: 99))
    }
    
    func testTitleForIndexMatchesOptionTitle() {
        // run loop checking all possible matched title from given index
        for index in 0..<viewModel.count {
            let expectedTitle = HomeOption.allCases[index].title
            XCTAssertEqual(viewModel.title(for: index), expectedTitle)
        }
    }

}
