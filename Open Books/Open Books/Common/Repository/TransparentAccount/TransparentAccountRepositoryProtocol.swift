//
//  TransparentAccountRepositoryProtocol.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

protocol TransparentAccountRepositoryProtocol {
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void)
    func fetchAccounts(page: Int, completion: @escaping (Result<PaginatedData<TransparentAccount>, Error>) -> Void)
    func fetchAccountDetails(accountId: String, completion: @escaping (Result<TransparentAccount, Error>) -> Void)
    
    func fetchCachedAccounts(completion: @escaping (Result<PaginatedData<TransparentAccount>, Error>) -> Void)
    func fetchCachedAccountDetails(accountId: String, completion: @escaping (Result<TransparentAccount?, Error>) -> Void)
    
    func fetchAccountTransactions(accountId: String, page: Int, completion: @escaping (Result<PaginatedData<Transaction>, Error>) -> Void)
}

// Mark: - Dependency Injection
extension Container {
    var transparentAccountRepository: Factory<TransparentAccountRepositoryProtocol> {
        self { TransparentAccountRepository() }
    }
}
