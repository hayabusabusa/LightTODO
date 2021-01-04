//
//  TodoModel.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import Foundation

protocol TodoModelDelegate: AnyObject {
    func onSuccess()
}

final class TodoModel {
    
    private let provider: UserDefaultsProviderProtocol
    weak var delegate: TodoModelDelegate?
    
    init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.shared) {
        self.provider = provider
    }
    
    func removeTodo(of id: String) {
        guard let storedTodos = provider.decodable(Todos.self, for: .todos),
              let index = storedTodos.items.firstIndex(where: { $0.id == id }) else {
            return
        }
        var items = storedTodos.items
        items.remove(at: index)
        
        provider.set(encodable: Todos(items: items), for: .todos)
        delegate?.onSuccess()
    }
}
