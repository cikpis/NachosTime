//
//  NowPlayingWebServiceTests.swift
//  NachosTimeTests
//
//  Created by Carmelo Gallo on 28/09/2018.
//  Copyright © 2018 Carmelo Gallo. All rights reserved.
//

import XCTest
@testable import NachosTime

class NowPlayingWebServiceTests: XCTestCase {
    
    func testGetNowPlaying() {
        let expectation = self.expectation(description: "\(#function)\(#line)")
        Manager.webService.nowPlaying.get(at: 1) { result in
            XCTAssertTrue(result.isSuccess)
            XCTAssertNotNil(result.value)
            expectation.fulfill()
        }
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertTrue(result == .completed)
    }

    func testGetSearch() {
        let expectation = self.expectation(description: "\(#function)\(#line)")
        Manager.webService.search.get(at: 1, keyWords: "Marvel") { result in
            XCTAssertTrue(result.isSuccess)
            XCTAssertNotNil(result.value)
            expectation.fulfill()
        }
        let result = XCTWaiter.wait(for: [expectation], timeout: 5)
        XCTAssertTrue(result == .completed)
    }

}
