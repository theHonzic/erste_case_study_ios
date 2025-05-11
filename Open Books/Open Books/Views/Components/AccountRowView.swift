//
//  AccountRowView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountRowView: View {
    var account: TransparentAccount
    @State private var isPressed = false
    
    var body: some View {
        NavigationLink(value: Screen.accountDetails(id: account.accountNumber)) {
            VStack(alignment: .leading, spacing: 12) {
                // Header with name and balance
                HStack(alignment: .top) {
                    // Account icon and name
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.accentColor.opacity(0.1))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "building.columns.fill")
                                    .foregroundColor(.accentColor)
                            }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(account.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
                            Text(account.iban)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    // Balance
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(account.balance.formattedValue)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(account.actualizationDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Description if available
                if let description = account.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                        .padding(.leading, 52) // Align with the name
                }
            }
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            }
            .scaleEffect(isPressed ? 0.98 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}

#Preview {
    VStack(spacing: 16) {
        AccountRowView(account: .mock)
        AccountRowView(account: .mock)
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
