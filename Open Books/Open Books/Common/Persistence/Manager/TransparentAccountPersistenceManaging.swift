//
//  TransparentAccountPersistenceManaging.swift
//  Open Books
//
//  Created by Jan Janovec on 09.05.2025.
//

import Factory
import RealmSwift

protocol TransparentAccountPersistenceManaging {
    func saveAccount(_ account: TransparentAccount) throws
    func saveAccounts(_ accounts: [TransparentAccount]) throws
    func getAccount(withId id: String) throws -> TransparentAccount?
    func getAccounts() throws -> [TransparentAccount]
    func clearAccounts() throws
}

// MARK: - Dependency Injection
extension Container {
    var transparentAccountPersistenceManager: Factory<TransparentAccountPersistenceManaging> {
        self { TransparentAccountPersistenceManager(realm: try? Realm()) }.singleton
    }
}
