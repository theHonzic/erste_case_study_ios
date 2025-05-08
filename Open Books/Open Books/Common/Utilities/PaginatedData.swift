//
//  PaginatedData.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct PaginatedData<T> {
    let items: [T]
    let pageNumber: Int
    let pageSize: Int
    let pageCount: Int
    let nextPage: Int?
    let recordCount: Int
}
