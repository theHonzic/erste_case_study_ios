//
//  TransparentAccountEndpoint.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

enum TransparentAccountEndpoint {
    case healthCheck
    case accounts(page: Int, size: Int = .DEFAULT_PAGE_SIZE)
    case account(id: String)
    case transactions(accountId: String, page: Int, size: Int = .DEFAULT_PAGE_SIZE)

    var path: URL {
        guard var components = URLComponents(url: Configuration.baseURL, resolvingAgainstBaseURL: false) else {
            fatalError("Invalid base URL: \(Configuration.baseURL)")
        }

        switch self {
        case .healthCheck:
            components.path.append("/health")

        case .accounts(let page, let size):
            // No extra path, just add query items
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)")
            ]

        case .account(let id):
            components.path.append("/\(id)")

        case .transactions(let accountId, let page, let size):
            components.path.append("/\(accountId)/transactions")
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "size", value: "\(size)")
            ]
        }

        guard let url = components.url else {
            fatalError("Failed to build URL from components: \(components)")
        }
        return url
    }
}
