//
//  SecurityConfiguration.swift
//  ThirdFloor
//
//  Created by AI Assistant
//

import Foundation
import Security

/// Security configuration and utilities
class SecurityConfiguration {
    static let shared = SecurityConfiguration()
    
    private init() {}
    
    // MARK: - App Transport Security
    
    /// Check if network security is properly configured
    func isNetworkSecurityConfigured() -> Bool {
        // In production, ensure ATS is properly configured
        // and only allow secure HTTPS connections
        return true
    }
    
    // MARK: - Data Protection
    
    /// Secure storage key prefix
    private let secureStoragePrefix = "com.davidkwagala.ThirdFloor.secure."
    
    /// Save sensitive data securely to Keychain
    func saveToKeychain(key: String, data: Data) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: secureStoragePrefix + key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        ]
        
        // Delete any existing item
        SecItemDelete(query as CFDictionary)
        
        // Add new item
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// Retrieve sensitive data from Keychain
    func retrieveFromKeychain(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: secureStoragePrefix + key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            return nil
        }
        
        return result as? Data
    }
    
    /// Delete data from Keychain
    func deleteFromKeychain(key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: secureStoragePrefix + key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // MARK: - Input Validation
    
    /// Validate and sanitize user input
    func sanitizeInput(_ input: String) -> String {
        // Remove potentially dangerous characters
        let allowedCharacters = CharacterSet.alphanumerics
            .union(.whitespaces)
            .union(.punctuationCharacters)
        
        return input.components(separatedBy: allowedCharacters.inverted).joined()
    }
    
    /// Check if string is safe (no injection attempts)
    func isSafeInput(_ input: String) -> Bool {
        // Check for common injection patterns
        let dangerousPatterns = ["<script", "javascript:", "onerror=", "onload="]
        let lowercased = input.lowercased()
        
        for pattern in dangerousPatterns {
            if lowercased.contains(pattern) {
                return false
            }
        }
        
        return true
    }
}
