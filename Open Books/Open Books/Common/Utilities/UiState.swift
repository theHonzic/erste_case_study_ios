//
//  UiState.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Foundation

enum UiState<T> {
    case loading
    case success(T, Bool = false)
    case error(Error)
}
