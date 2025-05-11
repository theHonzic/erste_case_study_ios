//
//  TransparentAccountRepository.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

final class TransparentAccountRepository {
    private let apiManager: TransparentAccountAPIManaging = Container.shared.transparentAccountAPIManager()
    private let persistenceManager: TransparentAccountPersistenceManaging = Container.shared.transparentAccountPersistenceManager()
}

extension TransparentAccountRepository: TransparentAccountRepositoryProtocol {
    func fetchCachedAccounts(completion: @escaping (Result<PaginatedData<TransparentAccount>, any Error>) -> Void) {
        persistenceManager.getAccounts { result in
            switch result {
            case .success(let accounts):
                completion(.success(.singlePage(accounts)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCachedAccountDetails(accountId: String, completion: @escaping (Result<TransparentAccount?, any Error>) -> Void) {
        persistenceManager.getAccount(withId: accountId, completion: completion)
    }
    
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void) {
        return apiManager.fetchHealthCheck(completion: completion)
    }
    
    func fetchAccounts(page: Int, completion: @escaping (Result<PaginatedData<TransparentAccount>, any Error>) -> Void) {
        apiManager
            .fetchTransparentAccounts(page: page, size: .DEFAULT_PAGE_SIZE) { result in
                switch result {
                case .success(let response):
                    // Save accounts to persistence
                    try? self.persistenceManager.saveAccounts(response.accounts.compactMap { .init(from: $0) })
                    
                    completion(
                        .success(
                            .init(
                                items: response.accounts.compactMap { .init(from: $0) },
                                pageNumber: response.pageNumber,
                                pageSize: response.pageSize,
                                pageCount: response.pageCount,
                                nextPage: response.nextPage,
                                recordCount: response.recordCount
                            )
                        )
                    )
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchAccountDetails(accountId: String, completion: @escaping (Result<TransparentAccount, any Error>) -> Void) {
        apiManager.fetchTransparentAccountDetails(accountId: accountId) { result in
            switch result {
            case .success(let response):
                guard let account = TransparentAccount(from: response) else {
                    completion(.failure(APIError.currencyIsMissing))
                    return
                }
                
                // Save account to persistence
                try? self.persistenceManager.saveAccount(account)
                
                completion(.success(account))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAccountTransactions(accountId: String, page: Int, completion: @escaping (Result<PaginatedData<Transaction>, any Error>) -> Void) {
        apiManager.fetchAccountTransactions(accountId: accountId, page: page, size: .DEFAULT_PAGE_SIZE) { result in
            switch result {
            case .success(let response):
                completion(
                    .success(
                        .init(
                            items: response.transactions.compactMap { .init(from: $0) },
                            pageNumber: response.pageNumber,
                            pageSize: response.pageSize,
                            pageCount: response.pageCount,
                            nextPage: response.nextPage,
                            recordCount: response.recordCount
                        )
                    )
                )
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
