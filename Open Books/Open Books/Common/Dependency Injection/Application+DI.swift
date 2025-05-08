//
//  Application+DI.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation
import Swinject

extension Open_BooksApp {
    func configureSwinject() {
        let container = Container()
        
        // Register your dependencies here
        container.register(TransparentAccountAPIManaging.self) { _ in
            TransparentAccountAPIManager()
        }
        container.register(TransparentAccountRepositoryType.self) { resolver in
            TransparentAccountRepository(apiManager: resolver.resolve(TransparentAccountAPIManaging.self)!)
        }
    }
}
