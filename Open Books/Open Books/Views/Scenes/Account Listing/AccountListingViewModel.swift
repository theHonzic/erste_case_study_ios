//
//  AccountListingViewModel.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Factory
import Foundation

final class AccountListingViewModel: ObservableObject {
    @Published var accounts: UiState<PaginatedData<TransparentAccount>> = .loading
    @Published var isErrorMessageVisible = false
    
    private var nextPage: Int {
        guard case let .success(data, _) = accounts else {
            return 0
        }
        return data.nextPage ?? 0
    }
    
    private let repository: TransparentAccountRepositoryProtocol
    
    init(repository: TransparentAccountRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Public Methods
extension AccountListingViewModel {
    func onAppear() {
        repository.fetchCachedAccounts { [weak self] result in
            if let data = try? result.get() {
                self?.accounts = .success(data)
            }
        }
        
        fetchFromNetwork()
    }
    
    func onRefresh() {
        fetchFromNetwork()
    }
    
    func onLoadMore() {
        guard case let .success(data, _) = accounts else {
            return
        }
        
        guard !data.isLastPage else {
            return
        }
        
        fetchFromNetwork()
    }
}

// MARK: - Private Methods
extension AccountListingViewModel {
    private func fetchFromNetwork() {
        repository.fetchAccounts(page: self.nextPage) { [weak self] result in
            switch result {
            case .success(let data):
                self?.accounts = .success(data, !data.isLastPage)
                
            case .failure(let error):
                // If we’ve already got a .success payload, leave it
                guard case .success = self?.accounts else {
                    self?.accounts = .error(error)
                    return
                }
                
                // If there are some accounts already, show the error message
                self?.isErrorMessageVisible = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self?.isErrorMessageVisible = false
                }
            }
        }
    }
}
            

// MARK: - Dependency Injection
extension Container {
    var accountListingViewModel: Factory<AccountListingViewModel> {
        self { AccountListingViewModel(repository: Container.shared.transparentAccountRepository()) }
    }
}
