//
//  TodoModel.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import Foundation

protocol TodoModelDelegate: AnyObject {
    
}

final class TodoModel {
    
    private let provider: UserDefaultsProviderProtocol
    weak var delegate: TodoModelDelegate?
    
    init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.shared) {
        self.provider = provider
    }
    
    func removeTodo() {
        
    }
}
