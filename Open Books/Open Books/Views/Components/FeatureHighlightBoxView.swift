//
//  FeatureHighlightBoxView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct FeatureHighlightBoxView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(systemName: "sparkles")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                
                Text("Features")
                    .font(.headline)
                
                Spacer()
            }
            
            // Dynamic feature rows
            VStack(alignment: .leading, spacing: 12) {
                FeatureRow(
                    title: "Browse Transparent Accounts",
                    icon: "list.bullet",
                    description: "Explore a list of transparent accounts listed on Česká Spořitelna API."
                )
                FeatureRow(
                    title: "View Account Details",
                    icon: "doc.plaintext",
                    description: "Get detailed information about each transparent account."
                )
                FeatureRow(
                    title: "Fetch Transactions",
                    icon: "arrow.right.circle",
                    description: "Retrieve transactions for a specific transparent account."
                )
                FeatureRow(
                    title: "Offline Support",
                    icon: "bolt.fill",
                    description: "Access previously fetched account data even when offline."
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.accentColor.opacity(0.1))
        )
    }
}

// Individual feature row view
private struct FeatureRow: View {
    let title: String
    let icon: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.accentColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
