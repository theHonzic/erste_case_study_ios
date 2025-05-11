//
//  Configuration.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation

struct Configuration {
    enum ConfigKey: String {
        case apiKey = "API_KEY"
        case baseURL = "BASE_URL"
    }
    
    static let baseURLString: String = {
        guard let url = Bundle.main.object(forInfoDictionaryKey: ConfigKey.baseURL.rawValue) as? String else {
            fatalError("Base URL not found in Info.plist")
        }
        
        return url
    }()
    
    static let baseURL: URL = {
        guard let url = URL(string: baseURLString) else {
            fatalError("Invalid Base URL")
        }
        
        return url
    }()

    
    static let apiKey: String = {
        guard let key = Bundle.main.object(forInfoDictionaryKey: ConfigKey.apiKey.rawValue) as? String else {
            fatalError("API Key not found in Info.plist")
        }
        
        return key
    }()
    
    static let repositoryURL: URL = .init(string: "https://github.com/theHonzic/erste_case_study_ios")!
}
