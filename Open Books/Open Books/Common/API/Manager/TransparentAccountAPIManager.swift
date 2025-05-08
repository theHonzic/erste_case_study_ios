//
//  TransparentAccountAPIManager.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Alamofire
import Foundation

final class TransparentAccountAPIManager: TransparentAccountAPIManaging {
    func fetchTransparentAccounts(page: Int, size: Int, completion: @escaping (Result<AccountPagedResponseDTO, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.accounts.path, headers: .defaultHeaders)
            .validate()
            .responseDecodable(of: AccountPagedResponseDTO.self) { response in
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
            .responseDecodable(of: AccountDTO.self) { response in
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
}
