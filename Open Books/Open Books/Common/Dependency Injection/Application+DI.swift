//
//  Application+DI.swift
//  Open Books
//
//  Created by Jan Janovec on 08.05.2025.
//

import Foundation
import Factory

extension Container {
    var transparentAccountAPIManager: Factory<TransparentAccountAPIManaging> {
        self { TransparentAccountAPIManager() }
    }
    
    var transparentAccountRepository: Factory<TransparentAccountRepositoryType> {
        self { TransparentAccountRepository() }
    }
    
    var aboutViewModel: Factory<AboutViewModel> {
        self { AboutViewModel() }
    }
}
