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
    ///  - Returns: A boolean indicating the health status of the API.
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void)
    /// Fetches list of transparent accounts.
    /// - Parameters:
    ///   - page: The page number to fetch.
    ///   - size: The number of items per page.
    ///   - completion: The completion handler to call when the request is complete.
    ///   - Returns: A `AccountsResponseDTO` object containing the list of transparent accounts.
    func fetchTransparentAccounts(page: Int, size: Int, completion: @escaping (Result<AccountPagedResponseDTO, Error>) -> Void)
    /// Fetches details of a transparent account.
    /// - Parameters:
    ///  - accountId: The ID of the transparent account to fetch.
    ///  - completion: The completion handler to call when the request is complete.
    ///  - Returns: A `AccountDTO` object containing the details of the transparent account.
    ///  - Note: This method is used to fetch details of a specific transparent account.
    func fetchTransparentAccountDetails(accountId: String, completion: @escaping (Result<AccountDTO, Error>) -> Void)
}

// MARK: - Dependency Injection
extension Container {
    var transparentAccountAPIManager: Factory<TransparentAccountAPIManaging> {
        self { TransparentAccountAPIManager() }
            .singleton
    }
}
