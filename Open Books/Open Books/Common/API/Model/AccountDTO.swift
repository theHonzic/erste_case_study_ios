//
//  AccountDTO.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct AccountDTO: Decodable {
    let accountNumber: String
    let bankCode: String
    let balance: Double
    let currency: String?
    let name: String
    let description: String?
    let note: String?
    let iban: String
    let actualizationDate: Date
}
