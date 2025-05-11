//
//  InfoCardView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct InfoCardView: View {
    let title: String
    let description: String
    let image: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
                .foregroundStyle(Color.accentColor)
            
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
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    InfoCardView(
        title: "Sample Title",
        description: "Sample Description",
        image: "star"
    )
}
