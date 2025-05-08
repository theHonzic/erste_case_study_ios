//
//  TransparentAccount.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct TransparentAccount {
    let name: String
    let description: String
    let note: String
    let iban: String
    let accountNumber: String
    let bankCode: String
    let balance: Amount
}

// MARK: - Mapping
extension AccountDTO {
    func toDomain() -> TransparentAccount {
        return TransparentAccount(
            name: name,
            description: description,
            note: note,
            iban: iban,
            accountNumber: accountNumber,
            bankCode: bankCode,
            balance: .init(value: balance, currency: .getByCode(currency))
        )
    }
}
