//
//  ErrorHandlerTests.swift
//  ThirdFloorTests
//
//  Created by AI Assistant
//

import XCTest
@testable import ThirdFloor

/// Test suite for ErrorHandler
final class ErrorHandlerTests: XCTestCase {
    
    var errorHandler: ErrorHandler!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        errorHandler = ErrorHandler.shared
    }
    
    override func tearDownWithError() throws {
        errorHandler = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Error Handling Tests
    
    func testLogError() throws {
        let error = NSError(domain: "TestDomain", code: 100, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        
        // This should not crash
        errorHandler.log(error)
        XCTAssertTrue(true, "Logging error should not crash")
    }
    
    func testHandleError() throws {
        let error = NSError(domain: "TestDomain", code: 200, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        
        // This should not crash
        errorHandler.handle(error, showAlert: false)
        XCTAssertTrue(true, "Handling error should not crash")
    }
    
    func testHandleErrorWithAlert() throws {
        let error = NSError(domain: "TestDomain", code: 300, userInfo: [NSLocalizedDescriptionKey: "Test error with alert"])
        
        // This should not crash
        errorHandler.handle(error, showAlert: true)
        XCTAssertTrue(true, "Handling error with alert should not crash")
    }
    
    // MARK: - AppError Tests
    
    func testNetworkError() throws {
        let underlyingError = NSError(domain: "Network", code: 404, userInfo: nil)
        let appError = AppError.networkError(underlyingError)
        
        XCTAssertNotNil(appError.errorDescription)
        XCTAssertTrue(appError.errorDescription?.contains("Network Error") ?? false)
    }
    
    func testDataError() throws {
        let appError = AppError.dataError("Invalid data format")
        
        XCTAssertNotNil(appError.errorDescription)
        XCTAssertTrue(appError.errorDescription?.contains("Data Error") ?? false)
        XCTAssertTrue(appError.errorDescription?.contains("Invalid data format") ?? false)
    }
    
    func testUnknownError() throws {
        let appError = AppError.unknownError
        
        XCTAssertNotNil(appError.errorDescription)
        XCTAssertTrue(appError.errorDescription?.contains("unknown error") ?? false)
    }
}
