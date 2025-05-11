//
//  FeatureHighlightBox.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct FeatureHighlight: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
}

struct FeatureHighlightBox: View {
    var title: String
    var icon: String
    var features: [FeatureHighlight]
    var tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(tint)

                Text(title)
                    .font(.headline)

                Spacer()
            }

            // Dynamic feature rows
            VStack(alignment: .leading, spacing: 12) {
                ForEach(features) { feature in
                    FeatureRow(feature: feature, tint: tint)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(tint.opacity(0.1))
        )
    }
}

// Individual feature row view
private struct FeatureRow: View {
    let feature: FeatureHighlight
    let tint: Color

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: feature.icon)
                .font(.title3)
                .foregroundColor(tint)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(feature.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    FeatureHighlightBox(
        title: "Feature Highlights",
        icon: "star.fill",
        features: [
            FeatureHighlight(icon: "plus.circle", title: "Add Account", description: "Quickly add a new account."),
            FeatureHighlight(icon: "pencil.circle", title: "Edit Account", description: "Modify existing account details."),
            FeatureHighlight(icon: "trash.circle", title: "Delete Account", description: "Remove an account from your list.")
        ],
        tint: .accentColor
    )
        .padding()
} 
