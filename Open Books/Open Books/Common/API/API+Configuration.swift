//
//  Configuration+API.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Alamofire
import Foundation

extension HTTPHeaders {
    static let defaultHeaders: HTTPHeaders = [
        .init(name: "WEB-API-key", value: Configuration.apiKey)
    ]
}

extension Int {
    static let DEFAULT_PAGE_SIZE = 50
}
