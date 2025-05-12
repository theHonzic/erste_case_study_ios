//
//  Transaction.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Foundation

struct Transaction {
    let amount: Amount
    let type: String
    let dueDate: Date
    let processingDate: Date
    let sender: AccountHolder
    let receiver: AccountHolder
    let typeDescription: String
}

struct AccountHolder {
    let accountNumber: String
    let bankCode: String
    let iban: String
    let specificSymbol: String?
    let specificSymbolParty: String?
    let variableSymbol: String?
    let constantSymbol: String?
    let name: String?
    let description: String?
}

// MARK: - Mapping
extension Transaction {
    init?(from apiModel: TransactionDTO) {
        guard let currency = apiModel.amount.currency else {
            return nil
        }
        
        self.init(
            amount: Amount(value: apiModel.amount.value, currency: .getByCode(currency)),
            type: apiModel.type,
            dueDate: apiModel.dueDate,
            processingDate: apiModel.processingDate,
            sender: AccountHolder(
                accountNumber: apiModel.sender.accountNumber,
                bankCode: apiModel.sender.bankCode,
                iban: apiModel.sender.iban,
                specificSymbol: apiModel.sender.specificSymbol,
                specificSymbolParty: apiModel.sender.specificSymbolParty,
                variableSymbol: apiModel.sender.variableSymbol,
                constantSymbol: apiModel.sender.constantSymbol,
                name: apiModel.sender.name,
                description: apiModel.sender.description
            ),
            receiver: AccountHolder(
                accountNumber: apiModel.receiver.accountNumber,
                bankCode: apiModel.receiver.bankCode,
                iban: apiModel.receiver.iban,
                specificSymbol: apiModel.receiver.specificSymbol,
                specificSymbolParty: apiModel.receiver.specificSymbolParty,
                variableSymbol: apiModel.receiver.variableSymbol,
                constantSymbol: apiModel.receiver.constantSymbol,
                name: apiModel.receiver.name,
                description: apiModel.receiver.description
            ),
            typeDescription: apiModel.typeDescription
        )
    }
}

// MARK: - Conformance
extension Transaction: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(sender.accountNumber)
        hasher.combine(sender.bankCode)
        hasher.combine(receiver.accountNumber)
        hasher.combine(receiver.bankCode)
        hasher.combine(amount.value)
        hasher.combine(processingDate)
    }
    
    static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        return lhs.sender.accountNumber == rhs.sender.accountNumber &&
        lhs.sender.bankCode == rhs.sender.bankCode &&
        lhs.receiver.accountNumber == rhs.receiver.accountNumber &&
        lhs.receiver.bankCode == rhs.receiver.bankCode &&
        lhs.amount.value == rhs.amount.value &&
        lhs.processingDate == rhs.processingDate
    }
}

extension Transaction: Identifiable {
    var id: String {
        return "\(sender.accountNumber)-\(sender.bankCode)-\(receiver.accountNumber)-\(receiver.bankCode)-\(amount.value)-\(processingDate)"
    }
}

// MARK: - Mock
extension Transaction {
    static let mock = Transaction(
        amount: .init(value: 1000.0, currency: .czk),
        type: "Payment",
        dueDate: Date(),
        processingDate: Date(),
        sender: AccountHolder(
            accountNumber: "1234567890",
            bankCode: "0800",
            iban: "CZ6508000000192000145399",
            specificSymbol: nil,
            specificSymbolParty: nil,
            variableSymbol: nil,
            constantSymbol: nil,
            name: "Jan Novák",
            description: "Platba za služby"
        ),
        receiver: AccountHolder(
            accountNumber: "0987654321",
            bankCode: "0800",
            iban: "CZ6508000000192000145399",
            specificSymbol: nil,
            specificSymbolParty: nil,
            variableSymbol: nil,
            constantSymbol: nil,
            name: "Marie Nováková",
            description: "Platba za služby"
        ),
        typeDescription: "Platba za služby"
    )
}
