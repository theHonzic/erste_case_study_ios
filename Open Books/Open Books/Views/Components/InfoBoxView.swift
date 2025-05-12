//
//  InfoBoxView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct InfoBoxView: View {
    var title: String
    var description: String
    var image: String
    var tint: Color = .accentColor

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
                .foregroundStyle(tint)

            VStack(alignment: .center, spacing: 8) {
                Text(title)
                    .font(.headline)

                Text(description)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(tint.opacity(0.1))
        )
    }
}

#Preview {
    InfoBoxView(
        title: "Sample Title",
        description: "Sample Description",
        image: "star",
        tint: Color.blue
    )
}
