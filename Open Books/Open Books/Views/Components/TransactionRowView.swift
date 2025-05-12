//
//  TransactionRowView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct TransactionRowView: View {
    var transaction: Transaction
    var onTap: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack(alignment: .top) {
                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.accentColor.opacity(0.1))
                            .frame(width: 40, height: 40)
                            .overlay {
                                Image(systemName: "banknote")
                                    .foregroundColor(.accentColor)
                            }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(transaction.sender.description ?? transaction.sender.name ?? "\(transaction.sender.accountNumber)/\(transaction.sender.bankCode)")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
                            Text(transaction.sender.iban)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(transaction.amount.formattedValue)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(transaction.processingDate.formatted(date: .abbreviated, time: .omitted))
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    .multilineTextAlignment(.trailing)
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
