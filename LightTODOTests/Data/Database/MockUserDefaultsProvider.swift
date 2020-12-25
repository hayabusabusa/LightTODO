//
//  MockUserDefaultsProvider.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/25.
//

import Foundation
@testable import LightTODO

final class MockUserDefaultsProvider<C: Codable>: UserDefaultsProviderProtocol {
    private var stored: C?
    
    init(stored: C?) {
        self.stored = stored
    }
    
    func set<T: Encodable>(encodable value: T, for key: UserDefaultsProvider.Key) {
        if let value = value as? C {
            stored = value
        }
    }
    
    func decodable<T: Decodable>(_ type: T.Type, for key: UserDefaultsProvider.Key) -> T? {
        guard let stored = stored as? T else {
            return nil
        }
        return stored
    }
    
    func removeObject(for key: UserDefaultsProvider.Key) {
        stored = nil
    }
}
