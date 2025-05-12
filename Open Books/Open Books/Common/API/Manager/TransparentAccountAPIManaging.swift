//
//  TransparentAccountAPIManaging.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

protocol TransparentAccountAPIManaging {
    /// Fetches the health check status of the API.
    /// - Parameters:
    ///  - completion: The completion handler to call when the request is complete.
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void)
    /// Fetches list of transparent accounts.
    /// - Parameters:
    ///   - page: The page number to fetch.
    ///   - size: The number of items per page.
    ///   - completion: The completion handler to call when the request is complete.
    func fetchTransparentAccounts(page: Int, size: Int, completion: @escaping (Result<AccountPagedResponseDTO, Error>) -> Void)
    /// Fetches details of a transparent account.
    /// - Parameters:
    ///  - accountId: The ID of the transparent account to fetch.
    ///  - completion: The completion handler to call when the request is complete.
    func fetchTransparentAccountDetails(accountId: String, completion: @escaping (Result<AccountDTO, Error>) -> Void)
    /// Fetches list of account transactions.
    /// - Parameters:
    ///  - accountId: The ID of the transparent account.
    ///  - page: The page number to fetch.
    ///  - size: The number of items per page.
    ///  - completion: The completion handler to call when the request is complete.
    func fetchAccountTransactions(accountId: String, page: Int, size: Int, completion: @escaping (Result<TransactionPagedResponseDTO, Error>) -> Void)
}

// MARK: - Dependency Injection
extension Container {
    var transparentAccountAPIManager: Factory<TransparentAccountAPIManaging> {
        self { TransparentAccountAPIManager() }
            .singleton
    }
}
