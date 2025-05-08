//
//  TransparentAccountRepository.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

final class TransparentAccountRepository: TransparentAccountRepositoryType {
    private let apiManager: TransparentAccountAPIManaging = Container.shared.transparentAccountAPIManager.resolve()

    func fetchAccounts(page: Int, completion: @escaping (Result<PaginatedData<TransparentAccount>, any Error>) -> Void) {
        apiManager
            .fetchTransparentAccounts(page: page, size: .DEFAULT_PAGE_SIZE) { result in
                switch result {
                case .success(let response):
                    completion(
                        .success(
                            .init(
                                items: response.accounts.map({ $0.toDomain() }),
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
    
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void) {
        return apiManager.fetchHealthCheck(completion: completion)
    }
}
