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
        let filteredTodos = todos?.items.filter { !$0.isCompleted } ?? []
        delegate?.onSuccess(todos: filteredTodos)
    }
    
    func completeTodo(of id: String) {
        guard let storedTodos = provider.decodable(Todos.self, for: .todos),
              let index = storedTodos.items.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        var items = storedTodos.items
        items[index].isCompleted = true
        
        provider.set(encodable: Todos(items: items), for: .todos)
    }
}
