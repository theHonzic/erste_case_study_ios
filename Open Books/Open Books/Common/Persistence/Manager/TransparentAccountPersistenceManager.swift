//
//  TransparentAccountPersistenceManager.swift
//  Open Books
//
//  Created by Jan Janovec on 09.05.2025.
//

import Foundation
import RealmSwift

final class TransparentAccountPersistenceManager {
    let realm: Realm?
    
    init(realm: Realm?) {
        self.realm = realm
    }
}

extension TransparentAccountPersistenceManager: TransparentAccountPersistenceManaging {
    func saveAccount(_ account: TransparentAccount) throws {
        guard let realm = realm else {
            throw PersistenceError.realmInitializationFailed
        }
        
        try realm.write {
            realm.add(AccountEntity(from: account), update: .modified)
        }
    }
    
    func saveAccounts(_ accounts: [TransparentAccount]) throws {
        guard let realm = realm else {
            throw PersistenceError.realmInitializationFailed
        }
        
        try realm.write {
            realm.add(accounts.map { AccountEntity(from: $0) }, update: .modified)
        }
    }
    
    func getAccount(withId id: String) throws -> TransparentAccount? {
        guard let realm = realm else {
            throw PersistenceError.realmInitializationFailed
        }
        
        let accountEntity = realm.object(ofType: AccountEntity.self, forPrimaryKey: id)
        return accountEntity.map { TransparentAccount(from: $0) }
    }
    
    func getAccounts() throws -> [TransparentAccount] {
        guard let realm = realm else {
            throw PersistenceError.realmInitializationFailed
        }
        
        let accountEntities = realm.objects(AccountEntity.self)
        return accountEntities.compactMap { TransparentAccount(from: $0) }
    }
    
    func clearAccounts() throws {
        guard let realm = realm else {
            throw PersistenceError.realmInitializationFailed
        }
        
        try realm.write {
            realm.delete(realm.objects(AccountEntity.self))
        }
    }
}
