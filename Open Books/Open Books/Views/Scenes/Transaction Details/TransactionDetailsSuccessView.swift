//
//  TransactionDetailsSuccessView.swift
//  Open Books
//
//  Created by Jan Janovec on 12.05.2025.
//

import SwiftUI

struct TransactionDetailsSuccessView: View {
    var transaction: Transaction
    
    var body: some View {
        LazyVStack(spacing: 16) {
            header
                .padding(.top, 32)
            
            transactionData
        }
        .padding(16)
    }
}

// MARK: - Components
extension TransactionDetailsSuccessView {
    private var header: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(Color.accentColor.opacity(0.1))
                .frame(width: 72, height: 72)
                .overlay {
                    Image(systemName: "banknote")
                        .foregroundColor(.accentColor)
                }
            
            Text(transaction.amount.formattedValue)
                .font(.largeTitle)
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                Text(transaction.sender.description ?? transaction.sender.name ?? "\(transaction.sender.accountNumber)/\(transaction.sender.bankCode)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text(transaction.typeDescription)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    @ViewBuilder
        private var transactionData: some View {
            VStack(spacing: 8) {
                makeDictionaryContainer(
                    title: "Transaction Details",
                    data: [
                        ("Amount", transaction.amount.formattedValue),
                        ("Type", transaction.typeDescription),
                        ("Due Date", transaction.dueDate.formatted()),
                        ("Processing Date", transaction.processingDate.formatted())
                    ]
                )
                makeDictionaryContainer(
                    title: "Sender Details",
                    data: [
                        ("Name", transaction.sender.name),
                        ("Description", transaction.sender.description),
                        ("IBAN", transaction.sender.iban),
                        ("Account Number", transaction.sender.accountNumber),
                        ("Bank Code", transaction.sender.bankCode)
                    ]
                )
                makeDictionaryContainer(
                    title: "Receiver Details",
                    data: [
                        ("Name", transaction.receiver.name),
                        ("Description", transaction.receiver.description),
                        ("IBAN", transaction.receiver.iban),
                        ("Account Number", transaction.receiver.accountNumber),
                        ("Bank Code", transaction.receiver.bankCode)
                    ]
                )
            }
        }

        @ViewBuilder
        private func makeDictionaryContainer(
            title: String,
            data: [(String, String?)]
        ) -> some View {
            // Filter out empty or nil values
            let filtered = data.compactMap { key, value in
                if let value = value, !value.isEmpty {
                    return (key, value)
                }
                
                return nil
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .padding(.bottom, 4)
                VStack(spacing: 4) {
                    ForEach(filtered, id: \.0) { key, value in
                        HStack {
                            Text(key)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text(value)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                }
            }
        }
}

#Preview {
    TransactionDetailsSuccessView(
        transaction: .mock
    )
}
