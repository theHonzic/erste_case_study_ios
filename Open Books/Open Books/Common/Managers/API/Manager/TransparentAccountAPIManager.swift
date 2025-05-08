//
//  TransparentAccountAPIManager.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Alamofire
import Foundation

class TransparentAccountAPIManager: TransparentAccountAPIManaging {
    func fetchHealthCheck(completion: @escaping (Result<Bool, any Error>) -> Void) {
        AF.request(TransparentAccountEndpoint.healthCheck.path)
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
