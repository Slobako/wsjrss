//
//  WebViewUITests.swift
//  wsjrssUITests
//
//  Created by Slobodan Kovrlija on 2/4/19.
//  Copyright © 2019 Slobodan. All rights reserved.
//

import XCTest

class WebViewUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

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

    func test_WebViewOnScreen() {
        
        let window = app.windows.element(boundBy: 0)
        let element = app.webViews
        XCTAssert(window.frame.contains(element.accessibilityFrame))
    }
}
