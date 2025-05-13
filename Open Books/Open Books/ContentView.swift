//
//  ContentView.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            AccountListingView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .accountDetails(let accountId):
                        AccountDetailsView(accountId: accountId)
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
