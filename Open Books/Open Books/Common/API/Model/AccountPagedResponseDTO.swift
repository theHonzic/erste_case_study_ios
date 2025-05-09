//
//  AccountPagedResponseDTO.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct AccountPagedResponseDTO: Decodable {
    let pageNumber: Int
    let pageCount: Int
    let pageSize: Int
    let recordCount: Int
    let nextPage: Int?
    let accounts: [AccountDTO]
}
