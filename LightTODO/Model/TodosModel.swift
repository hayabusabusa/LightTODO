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
    
    func getTodos(of type: TodoType) {
        let todos = provider.decodable(Todos.self, for: .todos)
        let items = todos?.items.filter { type == .uncompleted ? !$0.isCompleted : $0.isCompleted } ?? []
        delegate?.onSuccess(todos: items)
    }
    
    func toggleTodoCategory(to type: TodoType) {
        let todos = provider.decodable(Todos.self, for: .todos)
        let items = todos?.items.filter { type == .uncompleted ? !$0.isCompleted : $0.isCompleted } ?? []
        
        delegate?.onSuccess(todos: items)
    }
    
    func toggleTodo(of id: String) {
        guard let storedTodos = provider.decodable(Todos.self, for: .todos),
              let index = storedTodos.items.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        var items = storedTodos.items
        items[index].isCompleted.toggle()
        
        provider.set(encodable: Todos(items: items), for: .todos)
    }
}
