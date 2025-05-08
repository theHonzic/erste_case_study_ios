//
//  AboutViewModel.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

final class AboutViewModel: ObservableObject {
    @Published var isApiAvailable: Bool = true
    
    private let repository: TransparentAccountRepositoryType = Container.shared.transparentAccountRepository.resolve()
    
    init() {
        repository.fetchHealthCheck { [weak self] result in
            switch result {
            case .success(let isAvailable):
                DispatchQueue.main.async {
                    self?.isApiAvailable = isAvailable
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.isApiAvailable = false
                }
            }
        }
    }
}

