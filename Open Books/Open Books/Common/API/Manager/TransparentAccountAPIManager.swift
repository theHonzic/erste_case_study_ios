//
//  TransparentAccountAPIManager.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Alamofire
import Foundation

final class TransparentAccountAPIManager {
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "CET")
        
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return decoder
    }()
}

extension TransparentAccountAPIManager: TransparentAccountAPIManaging {
    func fetchTransparentAccounts(page: Int, size: Int, completion: @escaping (Result<AccountPagedResponseDTO, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.accounts(page: page, size: size).path, headers: .defaultHeaders)
            .validate()
            .responseDecodable(of: AccountPagedResponseDTO.self, decoder: decoder) { response in
                switch response.result {
                case .success(let accounts):
                    completion(.success(accounts))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchTransparentAccountDetails(accountId: String, completion: @escaping (Result<AccountDTO, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.account(id: accountId).path, headers: .defaultHeaders)
            .validate()
            .responseDecodable(of: AccountDTO.self, decoder: decoder) { response in
                switch response.result {
                case .success(let account):
                    completion(.success(account))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchHealthCheck(completion: @escaping (Result<Bool, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.healthCheck.path, headers: .defaultHeaders)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
    }
    
    func fetchAccountTransactions(accountId: String, page: Int, size: Int, completion: @escaping (Result<TransactionPagedResponseDTO, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.transactions(accountId: accountId, page: page, size: size).path, headers: .defaultHeaders)
            .validate()
            .responseDecodable(of: TransactionPagedResponseDTO.self, decoder: decoder) { response in
                switch response.result {
                case .success(let transactions):
                    completion(.success(transactions))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
                }
            }
    }
}
