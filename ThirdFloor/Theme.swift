//
//  Theme.swift
//  ThirdFloor
//
//  Created by AI Assistant
//

import SwiftUI

/// Theme configuration for consistent styling across the app
enum Theme {
    // MARK: - Colors
    enum Colors {
        static let primary = Color.blue
        static let secondary = Color.gray
        static let background = Color(.systemBackground)
        static let secondaryBackground = Color(.secondarySystemBackground)
        static let accent = Color.blue
    }
    
    // MARK: - Spacing
    enum Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    // MARK: - Corner Radius
    enum CornerRadius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
    }
    
    // MARK: - Font Sizes
    enum FontSize {
        static let small: CGFloat = 12
        static let regular: CGFloat = 16
        static let medium: CGFloat = 18
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
}
