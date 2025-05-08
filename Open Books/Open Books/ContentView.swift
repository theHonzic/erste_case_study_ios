//
//  ContentView.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: AboutViewModel = Container.shared.aboutViewModel.resolve()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(viewModel.isApiAvailable)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
