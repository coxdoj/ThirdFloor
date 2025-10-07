//
//  ContentView.swift
//  ThirdFloor
//
//  Created by David  on 23.09.25.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Globe icon with animation
                Image(systemName: "globe")
                    .imageScale(.large)
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                    .symbolEffect(.bounce, value: isAnimating)
                
                // Welcome text
                VStack(spacing: 8) {
                    Text("Welcome to ThirdFloor")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Leveraging powerful technologies")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                
                // Action button
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        isAnimating.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                        Text("Get Started")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(.blue)
                    .cornerRadius(10)
                }
                .accessibilityLabel("Get Started Button")
                .accessibilityHint("Tap to begin exploring ThirdFloor")
            }
            .padding()
            .navigationTitle("ThirdFloor")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}

