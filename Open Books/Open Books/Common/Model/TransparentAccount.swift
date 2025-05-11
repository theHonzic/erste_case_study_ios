//
//  TransparentAccount.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct TransparentAccount {
    let name: String
    let description: String?
    let note: String?
    let iban: String
    let accountNumber: String
    let bankCode: String
    let balance: Amount
    let actualizationDate: Date
}

// MARK: - Mapping

extension TransparentAccount {
    init?(from apiModel: AccountDTO) {
        guard let currency = apiModel.currency else {
            return nil
        }
        
        self.name = apiModel.name
        self.description = apiModel.description
        self.note = apiModel.note
        self.iban = apiModel.iban
        self.accountNumber = apiModel.accountNumber
        self.bankCode = apiModel.bankCode
        self.balance = .init(value: apiModel.balance, currency: .getByCode(currency))
        self.actualizationDate = apiModel.actualizationDate
    }
}
