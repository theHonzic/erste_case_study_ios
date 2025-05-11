//
//  AccountDetailsView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountDetailsView: View {
    var body: some View {
        NavigationLink(value: Screen.donation(id: "")) {
            Text("Donate")
        }
    }
}

#Preview {
    AccountDetailsView()
}
