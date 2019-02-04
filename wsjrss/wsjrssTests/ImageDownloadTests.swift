//
//  ImageDownloadTests.swift
//  wsjrssTests
//
//  Created by Slobodan Kovrlija on 2/4/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import XCTest
@testable import wsjrss

var sessionUnderTest: URLSession!

class ImageDownloadTests: XCTestCase {

    override func setUp() {
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
        super.tearDown()
    }

    func testValidCallToWsjHTTPStatusCode200() {
        // given
        let url = URL(string: "https://s.wsj.net/public/resources/images/S1-BV476_rusinf_G_20190202064551.jpg")
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            // then
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Asynchronous test: faster fail
    func testCallToWsjCompletes() {
        // given
        let url = URL(string: "https://s.wsj.net/public/resources/images/S1-BV476_rusinf_G_20190202064551.jpg")
        // 1
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            // 2
            promise.fulfill()
        }
        dataTask.resume()
        // 3
        waitForExpectations(timeout: 5, handler: nil)
        
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
