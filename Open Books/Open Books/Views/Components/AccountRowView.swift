//
//  AccountRowView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountRowView: View {
    var account: TransparentAccount
    
    var body: some View {
        NavigationLink(value: Screen.accountDetails(id: account.accountNumber)) {
            VStack(alignment: .leading, spacing: 8) {
                // Account name and balance
                HStack {
                    Text(account.name)
                        .lineLimit(1)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(account.balance.formattedValue)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                // Account description if available
                if let description = account.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                // Account details
                HStack {
                    Text(account.iban)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(account.actualizationDate.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

#Preview {
    AccountRowView(account: .mock)
        .padding()
}
