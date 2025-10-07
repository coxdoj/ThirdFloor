//
//  ThirdFloorTests.swift
//  ThirdFloorTests
//
//  Created by AI Assistant
//

import XCTest
@testable import ThirdFloor

/// Main test suite for ThirdFloor app
final class ThirdFloorTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        XCTAssertTrue(true, "Example test should pass")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
            let result = (1...1000).reduce(0, +)
            XCTAssertEqual(result, 500500)
        }
    }
}
