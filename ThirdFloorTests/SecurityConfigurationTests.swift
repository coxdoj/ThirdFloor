//
//  SecurityConfigurationTests.swift
//  ThirdFloorTests
//
//  Created by AI Assistant
//

import XCTest
@testable import ThirdFloor

/// Test suite for SecurityConfiguration
final class SecurityConfigurationTests: XCTestCase {
    
    var security: SecurityConfiguration!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        security = SecurityConfiguration.shared
    }
    
    override func tearDownWithError() throws {
        security = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Input Validation Tests
    
    func testSanitizeInput() throws {
        let input = "Hello World! 123"
        let sanitized = security.sanitizeInput(input)
        XCTAssertEqual(sanitized, "Hello World! 123")
    }
    
    func testSanitizeInputWithSpecialCharacters() throws {
        let input = "Test<script>alert('xss')</script>"
        let sanitized = security.sanitizeInput(input)
        XCTAssertFalse(sanitized.contains("<script>"))
    }
    
    func testIsSafeInput() throws {
        let safeInput = "Hello World"
        XCTAssertTrue(security.isSafeInput(safeInput))
    }
    
    func testIsNotSafeInputWithScript() throws {
        let unsafeInput = "<script>alert('xss')</script>"
        XCTAssertFalse(security.isSafeInput(unsafeInput))
    }
    
    func testIsNotSafeInputWithJavaScript() throws {
        let unsafeInput = "javascript:alert('xss')"
        XCTAssertFalse(security.isSafeInput(unsafeInput))
    }
    
    // MARK: - Keychain Tests
    
    func testKeychainSaveAndRetrieve() throws {
        let key = "test_key"
        let testData = "Test Data".data(using: .utf8)!
        
        // Save
        let saveResult = security.saveToKeychain(key: key, data: testData)
        XCTAssertTrue(saveResult, "Should save data to keychain successfully")
        
        // Retrieve
        let retrievedData = security.retrieveFromKeychain(key: key)
        XCTAssertNotNil(retrievedData, "Should retrieve data from keychain")
        XCTAssertEqual(retrievedData, testData, "Retrieved data should match saved data")
        
        // Clean up
        _ = security.deleteFromKeychain(key: key)
    }
    
    func testKeychainDelete() throws {
        let key = "test_key_delete"
        let testData = "Test Data".data(using: .utf8)!
        
        // Save
        _ = security.saveToKeychain(key: key, data: testData)
        
        // Delete
        let deleteResult = security.deleteFromKeychain(key: key)
        XCTAssertTrue(deleteResult, "Should delete data from keychain successfully")
        
        // Verify deletion
        let retrievedData = security.retrieveFromKeychain(key: key)
        XCTAssertNil(retrievedData, "Data should be deleted from keychain")
    }
    
    func testNetworkSecurityConfiguration() throws {
        XCTAssertTrue(security.isNetworkSecurityConfigured())
    }
}
