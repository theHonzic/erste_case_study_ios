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


extension PaginatedData {
    func updateWithNewPage(_ newPage: PaginatedData<T>) -> PaginatedData<T> {
        return PaginatedData(
            items: items + newPage.items,
            pageNumber: newPage.pageNumber,
            pageSize: newPage.pageSize,
            pageCount: newPage.pageCount,
            nextPage: newPage.nextPage,
            recordCount: newPage.recordCount
        )
    }
    
    var isLastPage: Bool {
        return nextPage == nil
    }
    
    static func empty() -> PaginatedData<T> {
        return PaginatedData(
            items: [],
            pageNumber: 0,
            pageSize: 0,
            pageCount: 0,
            nextPage: nil,
            recordCount: 0
        )
    }
    
    static func singlePage(_ items: [T]) -> PaginatedData<T> {
        return PaginatedData(
            items: items,
            pageNumber: 1,
            pageSize: items.count,
            pageCount: 1,
            nextPage: nil,
            recordCount: items.count
        )
    }
}
