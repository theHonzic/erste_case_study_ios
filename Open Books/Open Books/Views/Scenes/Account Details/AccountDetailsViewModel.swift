//
//  AccountDetailsViewModel.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Factory
import Foundation

final class AccountDetailsViewModel: ObservableObject {
    @Published var account: UiState<TransparentAccount> = .loading
    @Published var transactions: UiState<PaginatedData<Transaction>> = .loading
    
    private let repository: TransparentAccountRepositoryProtocol
    
    private var nextPage: Int {
        guard case .success(let transactions, _) = transactions else {
            return 0
        }
        return transactions.nextPage ?? 0
    }
    
    init(repository: TransparentAccountRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Public Methods
extension AccountDetailsViewModel {
    func onAppear(accountId: String) {
        repository
            .fetchCachedAccountDetails(accountId: accountId) { [weak self] result in
                if let data = try? result.get() {
                    self?.account = .success(data)
                }
            }
        
        repository
            .fetchAccountDetails(accountId: accountId) { result in
                switch result {
                case .success(let data):
                    self.account = .success(data)
                case .failure(let error):
                    self.account = .error(error)
                }
            }
    }
    
    func onTransactionsAppear(accountId: String) {
        fetchTransactions(accountId: accountId)
    }
    
    func onLoadMoreTransactions(accountId: String) {
        guard case .success(let transactions, _) = transactions else {
            return
        }
        
        guard !transactions.isLastPage else {
            return
        }
        
        fetchTransactions(accountId: accountId)
    }
}
     
// MARK: - Private Methods
extension AccountDetailsViewModel {
    private func fetchTransactions(accountId: String) {
        repository
            .fetchAccountTransactions(accountId: accountId, page: nextPage) { [weak self] result in
                switch result {
                case .success(let data):
                    var oldTransactions = PaginatedData<Transaction>.empty()
                    if case .success(let transactions, _) = self?.transactions {
                        oldTransactions = transactions
                    }
                    let updatedTransactions = oldTransactions.updateWithNewPage(data)
                    self?.transactions = .success(updatedTransactions, !updatedTransactions.isLastPage)
                    
                case .failure(let error):
                    self?.transactions = .error(error)
                }
            }
    }
}

// MARK: - Dependency Injection
extension Container {
    var accountDetailsViewModel: Factory<AccountDetailsViewModel> {
        self { AccountDetailsViewModel(repository: Container.shared.transparentAccountRepository()) }
    }
}
