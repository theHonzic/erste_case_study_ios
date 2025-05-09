//
//  AboutViewModel.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Factory
import Foundation

final class AboutViewModel: ObservableObject {
    @Published var data: Any?
    
    private let repository: TransparentAccountRepositoryType = Container.shared.transparentAccountRepository.resolve()
    
    init() {
        repository.fetchAccountDetails(accountId: "000000-3840968309") { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.data = data
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.data = nil
                }
            }
        }
    }
}

