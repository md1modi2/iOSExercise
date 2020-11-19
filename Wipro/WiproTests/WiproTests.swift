//
//  WiproTests.swift
//  WiproTests
//
//  Created by hb on 06/11/20.
//  Copyright © 2020 Hiddenbrains. All rights reserved.
//

import XCTest
@testable import Wipro

class WiproTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetFacts() {
        let service = NetworkService()
        let session  = NetworkSession(data: nil, urlResponse: nil, error: nil)
        service.session = session
        let errorExpectation = expectation(description: "error")
        var errorResponse: Error?
        service.getFacts { (response, error) in
          errorResponse = error
          errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
          XCTAssertNotNil(errorResponse)
        }
    }

}
