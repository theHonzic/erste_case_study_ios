//
//  Screen.swift
//  Open Books
//
//  Created by Jan Janovec on 11.05.2025.
//

import Foundation

enum Screen: Identifiable {
    case accountDetails(id: String)
    case donation(id: String)
    
    var id: String {
        switch self {
        case .accountDetails(let id):
            return "accountDetails-\(id)"
        case .donation(let id):
            return "donation-\(id)"
        }
    }
}
