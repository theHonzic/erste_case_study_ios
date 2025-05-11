//
//  AccountListingView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountListingView: View {
    var body: some View {
        NavigationLink(value: Screen.accountDetails(id: "")) {
            Text("Account Details")
        }
        .navigationTitle("Browse Accounts")
    }
}

#Preview {
    AccountListingView()
}
