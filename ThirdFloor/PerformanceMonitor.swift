//
//  PerformanceMonitor.swift
//  ThirdFloor
//
//  Created by AI Assistant
//

import Foundation
import os.log

/// Performance monitoring utility
class PerformanceMonitor {
    static let shared = PerformanceMonitor()
    
    private init() {}
    
    private let logger = Logger(subsystem: "com.davidkwagala.ThirdFloor", category: "Performance")
    
    // MARK: - Time Measurement
    
    /// Measure execution time of a closure
    @discardableResult
    func measure<T>(name: String, operation: () throws -> T) rethrows -> T {
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = try operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        
        #if DEBUG
        logger.info("⏱ \(name) took \(String(format: "%.4f", timeElapsed))s")
        #endif
        
        return result
    }
    
    /// Measure async execution time
    func measureAsync<T>(name: String, operation: () async throws -> T) async rethrows -> T {
        let startTime = CFAbsoluteTimeGetCurrent()
        let result = try await operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        
        #if DEBUG
        logger.info("⏱ \(name) took \(String(format: "%.4f", timeElapsed))s")
        #endif
        
        return result
    }
    
    // MARK: - Memory Management
    
    /// Log current memory usage
    func logMemoryUsage() {
        #if DEBUG
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4
        
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                task_info(mach_task_self_,
                         task_flavor_t(MACH_TASK_BASIC_INFO),
                         $0,
                         &count)
            }
        }
        
        if kerr == KERN_SUCCESS {
            let usedMemory = Double(info.resident_size) / 1024.0 / 1024.0
            logger.info("💾 Memory usage: \(String(format: "%.2f", usedMemory)) MB")
        }
        #endif
    }
    
    // MARK: - Performance Tips
    
    /// Debounce function calls
    func debounce(delay: TimeInterval, action: @escaping () -> Void) -> () -> Void {
        var workItem: DispatchWorkItem?
        
        return {
            workItem?.cancel()
            workItem = DispatchWorkItem(block: action)
            if let workItem = workItem {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem)
            }
        }
    }
    
    /// Throttle function calls
    func throttle(interval: TimeInterval, action: @escaping () -> Void) -> () -> Void {
        var lastExecutionTime: Date?
        
        return {
            let now = Date()
            if let lastTime = lastExecutionTime {
                let timeElapsed = now.timeIntervalSince(lastTime)
                if timeElapsed < interval {
                    return
                }
            }
            
            lastExecutionTime = now
            action()
        }
    }
}
