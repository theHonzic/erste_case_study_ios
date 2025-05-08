//
//  Amount.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct Amount {
    let value: Double
    let currency: Currency
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: value)
        return formatter.string(from: number) ?? ""
    }
}
