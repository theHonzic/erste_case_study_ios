//
//  Currency.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

enum Currency: String, Codable {
    case czk = "CZK"
    case eur = "EUR"
    case usd = "USD"
    
    var symbol: String {
        switch self {
        case .czk:
            return "Kč"
        case .eur:
            return "€"
        case .usd:
            return "$"
        }
    }
    
    var code: String {
        rawValue
    }
    
    static func getByCode(_ code: String) -> Currency {
        switch code.uppercased() {
        case "CZK":
            return .czk
        case "EUR":
            return .eur
        case "USD":
            return .usd
        default:
            fatalError("Unsupported currency code: \(code)")
        }
    }
}
