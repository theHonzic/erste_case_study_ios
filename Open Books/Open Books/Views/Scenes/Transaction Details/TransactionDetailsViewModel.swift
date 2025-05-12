//
//  TransactionDetailViewModel.swift
//  Open Books
//
//  Created by Jan Janovec on 12.05.2025.
//

import Factory
import Foundation

final class TransactionDetailsViewModel: ObservableObject {
    @Published var transaction: UiState<Transaction> = .loading
    
    init(transaction: Transaction) {
        self.transaction = .success(transaction)
    }
}

// MARK: - Dependency Injection
extension Container {
    var transactionDetailsViewModel: ParameterFactory<Transaction, TransactionDetailsViewModel> {
        self { TransactionDetailsViewModel(transaction: $0) }
    }
}
