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

// MARK: - Mock
extension TransparentAccount {
    static let mock = TransparentAccount(
        name: "Jan Novák",
        description: "Transparentní účet pro osobní potřeby",
        note: "Poznámka k účtu",
        iban: "CZ6508000000192000145399",
        accountNumber: "1234567890",
        bankCode: "0800",
        balance: .init(value: 10000.0, currency: .czk),
        actualizationDate: Date()
    )
    
    static let mockList: [TransparentAccount] = [
        .init(
            name: "Jan Novák",
            description: "Transparentní účet pro osobní potřeby",
            note: "Poznámka k účtu",
            iban: "CZ6508000000192000145399",
            accountNumber: "1234567890",
            bankCode: "0800",
            balance: .init(value: 10000.0, currency: .czk),
            actualizationDate: Date()
        ),
        .init(
            name: "Marie Nováková",
            description: "Transparentní účet pro podnikání",
            note: nil,
            iban: "CZ6508000000192000145400",
            accountNumber: "1234567891",
            bankCode: "0800",
            balance: .init(value: 20000.0, currency: .czk),
            actualizationDate: Date()
        ),
        .init(
            name: "Petr Nový",
            description: "Transparentní účet pro charitu",
            note: "Poznámka k účtu",
            iban: "CZ6508000000192000145401",
            accountNumber: "1234567892",
            bankCode: "0800",
            balance: .init(value: 30000.0, currency: .czk),
            actualizationDate: Date()
        ),
        .init(
            name: "Eva Novotná",
            description: "Transparentní účet pro školu",
            note: nil,
            iban: "CZ6508000000192000145402",
            accountNumber: "1234567893",
            bankCode: "0800",
            balance: .init(value: 40000.0, currency: .czk),
            actualizationDate: Date()
        ),
        .init(
            name: "Tomáš Nový",
            description: "Transparentní účet pro sportovní klub",
            note: "Poznámka k účtu",
            iban: "CZ6508000000192000145403",
            accountNumber: "1234567894",
            bankCode: "0800",
            balance: .init(value: 50000.0, currency: .czk),
            actualizationDate: Date()
        )
    ]
}
