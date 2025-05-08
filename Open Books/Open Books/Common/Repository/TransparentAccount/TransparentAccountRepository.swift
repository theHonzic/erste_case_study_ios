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
    
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void) {
        return apiManager.fetchHealthCheck(completion: completion)
    }
}
