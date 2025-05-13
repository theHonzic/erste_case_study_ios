//
//  AccountDetailsSuccessView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import SwiftUI

struct AccountDetailsSuccessView: View {
    var account: TransparentAccount
    var transactions: UiState<PaginatedData<Transaction>>
    var onLoadMoreTransactions: () -> Void
    var onOpenTransaction: (Transaction) -> Void
    
    var body: some View {
        LazyVStack(spacing: 16) {
            header
                .padding(.top, 32)
            
            transactionList
        }
        .multilineTextAlignment(.center)
    }
}

// MARK: - Components
extension AccountDetailsSuccessView {
    private var header: some View {
        VStack(spacing: 16) {
            Circle()
                .fill(Color.accentColor.opacity(0.1))
                .frame(width: 72, height: 72)
                .overlay {
                    Image(systemName: "building.columns.fill")
                        .foregroundColor(.accentColor)
                }
            
            Text(account.balance.formattedValue)
                .font(.largeTitle)
                .foregroundColor(.primary)
            
            VStack(spacing: 8) {
                Text(account.name)
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                if let description = account.description {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    @ViewBuilder
    private var transactionList: some View {
        switch transactions {
        case .loading:
            InfoBoxView(
                title: "Loading transactions",
                description: "Please wait while we load your transactions.",
                image: "arrow.clockwise",
                tint: .accentColor
            )
        case .error(let error):
            InfoBoxView(
                title: "Something went wrong",
                description: error.localizedDescription,
                image: "exclamationmark.triangle.fill",
                tint: .red
            )
        case .success(let transactions, let isLoadingMore):
            if transactions.items.isEmpty {
                InfoBoxView(
                    title: "No transactions found",
                    description: "There are no transactions for this account.",
                    image: "tray.fill",
                    tint: .accentColor
                )
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(transactions.items, id: \.self) { transaction in
                        TransactionRowView(
                            transaction: transaction,
                            onTap: {
                                onOpenTransaction(transaction)
                            }
                        )
                    }
                    
                    if isLoadingMore {
                        VStack {
                            ProgressView()
                            
                            Text("Loading more transactions...")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .task {
                            onLoadMoreTransactions()
                        }
                    }
                }
            }
        }
    }
}
