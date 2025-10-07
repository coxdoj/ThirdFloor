//
//  ErrorHandler.swift
//  ThirdFloor
//
//  Created by AI Assistant
//

import Foundation

/// Custom error types for the application
enum AppError: LocalizedError {
    case networkError(Error)
    case dataError(String)
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .networkError(let error):
            return "Network Error: \(error.localizedDescription)"
        case .dataError(let message):
            return "Data Error: \(message)"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}

/// Error handling utility
class ErrorHandler {
    static let shared = ErrorHandler()
    
    private init() {}
    
    /// Log error for debugging purposes
    func log(_ error: Error, file: String = #file, function: String = #function, line: Int = #line) {
        #if DEBUG
        print("❌ Error in \(file):\(line) - \(function)")
        print("   \(error.localizedDescription)")
        #endif
    }
    
    /// Handle error with optional user feedback
    func handle(_ error: Error, showAlert: Bool = false) {
        log(error)
        
        // In production, you might want to send this to a crash reporting service
        // like Firebase Crashlytics or Sentry
        
        if showAlert {
            // Show alert to user (implement based on your UI framework)
            // For now, we just log it
            print("User should be notified: \(error.localizedDescription)")
        }
    }
}
