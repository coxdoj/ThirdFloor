//
//  ThirdFloorUITests.swift
//  ThirdFloorUITests
//
//  Created by AI Assistant
//

import XCTest

/// UI test suite for ThirdFloor app
final class ThirdFloorUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testMainViewElements() throws {
        // Check if navigation title exists
        XCTAssertTrue(app.navigationBars["ThirdFloor"].exists, "Navigation bar should exist")
        
        // Check if welcome text exists
        let welcomeText = app.staticTexts["Welcome to ThirdFloor"]
        XCTAssertTrue(welcomeText.exists, "Welcome text should exist")
        
        // Check if description text exists
        let descriptionText = app.staticTexts["Leveraging powerful technologies"]
        XCTAssertTrue(descriptionText.exists, "Description text should exist")
        
        // Check if get started button exists
        let getStartedButton = app.buttons["Get Started"]
        XCTAssertTrue(getStartedButton.exists, "Get Started button should exist")
    }
    
    func testGetStartedButtonTap() throws {
        // Find and tap the get started button
        let getStartedButton = app.buttons["Get Started"]
        XCTAssertTrue(getStartedButton.exists, "Get Started button should exist")
        
        // Tap the button
        getStartedButton.tap()
        
        // Verify the button still exists after tap (animation trigger)
        XCTAssertTrue(getStartedButton.exists, "Button should still exist after tap")
    }
    
    func testAccessibilityLabels() throws {
        // Check accessibility labels
        let getStartedButton = app.buttons["Get Started Button"]
        XCTAssertTrue(getStartedButton.exists, "Button should have accessibility label")
    }
}
