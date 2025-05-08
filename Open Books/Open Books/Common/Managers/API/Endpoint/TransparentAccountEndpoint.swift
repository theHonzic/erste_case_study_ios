//
//  TransparentAccountEndpoint.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

enum TransparentAccountEndpoint {
    case healthCheck
    case accounts
    case account(id: String)
    case transactions(accountId: String)
    
    var path: URL {
        var url = Configuration.baseURL
        
        switch self {
        case .healthCheck:
            url.appendPathComponent("health")
        case .accounts:
            break
        case .account(let id):
            url.appendPathComponent("/\(id)")
        case .transactions(let accountId):
            url.appendPathComponent("/\(accountId)/transactions")
        }
        
        return url
    }
}
