//
//  ContentView.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(Configuration.apiKey)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
