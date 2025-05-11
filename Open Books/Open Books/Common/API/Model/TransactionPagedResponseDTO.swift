//
//  TransactionPagedResponseDTO.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Foundation

struct TransactionPagedResponseDTO: Decodable {
    let pageNumber: Int
    let pageCount: Int
    let pageSize: Int
    let recordCount: Int
    let nextPage: Int?
    let transactions: [TransactionDTO]
}
