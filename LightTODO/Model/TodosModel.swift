//
//  TodosModel.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/25.
//

import Foundation

protocol TodosModelDelegate: AnyObject {
    func onSuccess(todos: [Todo])
}

final class TodosModel {
    
    private let provider: UserDefaultsProviderProtocol
    
    init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.shared) {
        self.provider = provider
    }
    
    weak var delegate: TodosModelDelegate?
    
    func getTodos() {
        let todos = provider.decodable(Todos.self, for: .todos)
        delegate?.onSuccess(todos: todos?.items ?? [])
    }
}
