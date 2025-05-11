//
//  TransactionDTO.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Foundation

struct TransactionDTO: Decodable {
    let amount: TransactionAmountDTO
    let type: String
    let dueDate: Date
    let processingDate: Date
    let sender: AccountHolderDTO
    let receiver: AccountHolderDTO
    let typeDescription: String
}

struct TransactionAmountDTO: Decodable {
    let value: Double
    let precision: Int
    let currency: String?
}

struct AccountHolderDTO: Decodable {
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
