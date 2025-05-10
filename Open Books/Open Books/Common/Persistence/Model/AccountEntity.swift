//
//  AccountEntity.swift
//  Open Books
//
//  Created by Jan Janovec on 09.05.2025.
//

import RealmSwift

final class AccountEntity: Object {
    @Persisted(primaryKey: true) var accountNumber: String
    @Persisted var bankCode: String
    @Persisted var balance: Double
    @Persisted var currency: String
    @Persisted var name: String
    @Persisted var description_: String?
    @Persisted var note: String?
    @Persisted var iban: String
    
    init(
        accountNumber: String,
        bankCode: String,
        balance: Amount,
        name: String,
        description: String?,
        note: String?,
        iban: String
    ) {
        super.init()
        
        self.accountNumber = accountNumber
        self.bankCode = bankCode
        self.balance = balance.value
        self.currency = balance.currency.code
        self.name = name
        self.description_ = description
        self.note = note
        self.iban = iban
    }
}

// MARK: - Mapping
extension AccountEntity {
    convenience init(from domainModel: TransparentAccount) {
        self.init(
            accountNumber: domainModel.accountNumber,
            bankCode: domainModel.bankCode,
            balance: domainModel.balance,
            name: domainModel.name,
            description: domainModel.description,
            note: domainModel.note,
            iban: domainModel.iban
        )
    }
}

extension TransparentAccount {
    init(from entity: AccountEntity) {
        self.accountNumber = entity.accountNumber
        self.bankCode = entity.bankCode
        self.balance = Amount(value: entity.balance, currency: .getByCode(entity.currency))
        self.name = entity.name
        self.description = entity.description_
        self.note = entity.note
        self.iban = entity.iban
    }
}
