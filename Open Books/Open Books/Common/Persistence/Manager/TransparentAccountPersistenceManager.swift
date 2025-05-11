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
    
    func getAccount(withId id: String, completion: @escaping (Result<TransparentAccount?, Error>) -> Void) {
        guard let realm = realm else {
            completion(.failure(PersistenceError.realmInitializationFailed))
            return
        }
        
        completion(.success(
            realm.object(ofType: AccountEntity.self, forPrimaryKey: id).map {
                TransparentAccount(from: $0)
            })
        )
    }
    
    func getAccounts(completion: @escaping (Result<[TransparentAccount], Error>) -> Void) {
        guard let realm = realm else {
            completion(.failure(PersistenceError.realmInitializationFailed))
            return
        }
        
        completion(.success(
            realm.objects(AccountEntity.self).compactMap {
                TransparentAccount(from: $0)
            }.sorted(by: { lhs, rhs in
                lhs.actualizationDate > rhs.actualizationDate
            }))
        )
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
