//
//  FeedItemModelTests.swift
//  wsjrssTests
//
//  Created by Slobodan Kovrlija on 2/4/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import XCTest
@testable import wsjrss

class FeedItemModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_InitHasAllProperties() {
        let feedItem = FeedItem(title: "", link: "", description: "", imageUrl: "", publicationDate: "", guid: "")
        
        XCTAssertNotNil(feedItem, "Feed item should not be nil")
        XCTAssertEqual(feedItem.title, "", "should set title")
        XCTAssertEqual(feedItem.description, "", "should set description")
        XCTAssertEqual(feedItem.link, "", "should set link")
        XCTAssertEqual(feedItem.imageUrl, "", "should set imageUrl")
        XCTAssertEqual(feedItem.publicationDate, "", "should set publicationDate")
        XCTAssertEqual(feedItem.guid, "", "should set guid")
    }
}
