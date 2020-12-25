//
//  UserDefaultsProvider.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/25.
//

import Foundation

protocol UserDefaultsProviderProtocol: AnyObject {
    /// Sets the encodable value of the key.
    /// - Parameters:
    ///   - value: The object to store in the defaults database.
    ///   - key: The key with which to associate the value.
    func set<T: Encodable>(encodable value: T, for key: UserDefaultsProvider.Key)
    
    /// Returns the decodable object associated with the specified key.
    /// - Parameters:
    ///   - type: The object type to store in the database.
    ///   - key: A key which can access stored object in the database.
    func decodable<T: Decodable>(_ type: T.Type, for key: UserDefaultsProvider.Key) -> T?
}

final class UserDefaultsProvider: UserDefaultsProviderProtocol {
    
    static let shared: UserDefaultsProvider = .init()
    
    private let userDefaults = UserDefaults.standard
    
    private init () {}
    
    enum Key: String {
        case todos
    }
    
    func set<T: Encodable>(encodable value: T, for key: Key) {
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        userDefaults.set(data, forKey: key.rawValue)
    }
    
    func decodable<T: Decodable>(_ type: T.Type, for key: Key) -> T? {
        guard let stored = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }
        return try? JSONDecoder().decode(type, from: stored)
    }
}
