//
//  FeedTableViewUITests.swift
//  wsjrssUITests
//
//  Created by Slobodan Kovrlija on 2/4/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import XCTest

class FeedTableViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TableViewExists() {
        app.launch()
        
        // Assert that tableview is being displayed by checking its accessibility identifier
        let feedTableView = app.tables["FeedTableView"]
        
        XCTAssertTrue(feedTableView.exists, "feedTableView exists")
        
    }

}
