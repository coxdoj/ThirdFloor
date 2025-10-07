//
//  PerformanceMonitorTests.swift
//  ThirdFloorTests
//
//  Created by AI Assistant
//

import XCTest
@testable import ThirdFloor

/// Test suite for PerformanceMonitor
final class PerformanceMonitorTests: XCTestCase {
    
    var monitor: PerformanceMonitor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        monitor = PerformanceMonitor.shared
    }
    
    override func tearDownWithError() throws {
        monitor = nil
        try super.tearDownWithError()
    }
    
    // MARK: - Measurement Tests
    
    func testMeasure() throws {
        let result = monitor.measure(name: "Test Operation") {
            return (1...100).reduce(0, +)
        }
        
        XCTAssertEqual(result, 5050, "Measure should return correct result")
    }
    
    func testMeasureWithThrowingOperation() throws {
        enum TestError: Error {
            case testError
        }
        
        XCTAssertThrowsError(try monitor.measure(name: "Throwing Operation") {
            throw TestError.testError
        })
    }
    
    func testMeasureAsync() async throws {
        let result = await monitor.measureAsync(name: "Async Test Operation") {
            return await withCheckedContinuation { continuation in
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    continuation.resume(returning: 42)
                }
            }
        }
        
        XCTAssertEqual(result, 42, "Async measure should return correct result")
    }
    
    func testLogMemoryUsage() throws {
        // This should not crash
        monitor.logMemoryUsage()
        XCTAssertTrue(true, "Logging memory usage should not crash")
    }
    
    // MARK: - Debounce Tests
    
    func testDebounce() throws {
        let expectation = XCTestExpectation(description: "Debounce should execute after delay")
        var executionCount = 0
        
        let debouncedFunction = monitor.debounce(delay: 0.2) {
            executionCount += 1
            expectation.fulfill()
        }
        
        // Call multiple times rapidly
        debouncedFunction()
        debouncedFunction()
        debouncedFunction()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(executionCount, 1, "Debounced function should execute only once")
    }
    
    // MARK: - Throttle Tests
    
    func testThrottle() throws {
        let expectation = XCTestExpectation(description: "Throttle should limit execution")
        expectation.expectedFulfillmentCount = 1
        
        var executionCount = 0
        
        let throttledFunction = monitor.throttle(interval: 0.5) {
            executionCount += 1
            expectation.fulfill()
        }
        
        // Call multiple times rapidly
        throttledFunction()
        throttledFunction()
        throttledFunction()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(executionCount, 1, "Throttled function should execute only once within interval")
    }
}
