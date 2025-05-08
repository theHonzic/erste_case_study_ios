//
//  TransparentAccountRepositoryType.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

protocol TransparentAccountRepositoryType {
    func fetchHealthCheck(completion: @escaping (Result<Bool, Error>) -> Void)
}
