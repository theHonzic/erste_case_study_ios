//
//  AccountEntity.swift
//  Open Books
//
//  Created by Jan Janovec on 09.05.2025.
//

import Foundation
import RealmSwift

final class AccountEntity: Object {
    @Persisted(primaryKey: true) var accountNumber: String
    @Persisted var bankCode: String
    @Persisted var balance: Double
    @Persisted var currency: String
    @Persisted var name: String
    @Persisted var accountDescription: String?
    @Persisted var note: String?
    @Persisted var iban: String
    @Persisted var actualizationDate: Date
}

// MARK: - Mapping
extension AccountEntity {
    convenience init(from domainModel: TransparentAccount) {
        self.init()
        self.accountNumber = domainModel.accountNumber
        self.bankCode = domainModel.bankCode
        self.balance = domainModel.balance.value
        self.currency = domainModel.balance.currency.code
        self.name = domainModel.name
        self.accountDescription = domainModel.description
        self.note = domainModel.note
        self.iban = domainModel.iban
        self.actualizationDate = domainModel.actualizationDate
    }
}

extension TransparentAccount {
    init(from entity: AccountEntity) {
        self.accountNumber = entity.accountNumber
        self.bankCode = entity.bankCode
        self.balance = Amount(value: entity.balance, currency: .getByCode(entity.currency))
        self.name = entity.name
        self.description = entity.accountDescription
        self.note = entity.note
        self.iban = entity.iban
        self.actualizationDate = entity.actualizationDate
    }
}
