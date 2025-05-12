//
//  AccountDetailsView.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Factory
import SwiftUI

struct AccountDetailsView: View {
    @StateObject private var viewModel: AccountDetailsViewModel = Container.shared.accountDetailsViewModel()
    @State private var displayedTransaction: Transaction?
    var accountId: String
    
    var body: some View {
        ScrollView {
            Group {
                switch viewModel.account {
                case .loading:
                    AccountDetailsSuccessView(
                        account: .mock,
                        transactions: .loading,
                        onLoadMoreTransactions: {},
                        onOpenTransaction: { _ in }
                    )
                        .redacted(reason: .placeholder)
                        .disabled(true)
                case .success(let account, _):
                    AccountDetailsSuccessView(
                        account: account,
                        transactions: viewModel.transactions,
                        onLoadMoreTransactions: {
                            viewModel.onLoadMoreTransactions(accountId: accountId)
                        },
                        onOpenTransaction: { transaction in
                            self.displayedTransaction = transaction
                        }
                    )
                    .onFirstAppear {
                        viewModel.onTransactionsAppear(accountId: accountId)
                    }
                case .error(let error):
                    InfoBoxView(
                        title: "Something went wrong",
                        description: error.localizedDescription,
                        image: "exclamationmark.triangle.fill",
                        tint: .red
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
        }
        .scrollBounceBehavior(.basedOnSize)
        .navigationTitle("Account Details")
        .onFirstAppear {
            viewModel.onAppear(accountId: accountId)
        }
        .sheet(item: $displayedTransaction) { transaction in
            TransactionDetailsView(
                transaction: transaction
            )
        }
    }
}
