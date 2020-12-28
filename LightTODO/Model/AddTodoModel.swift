//
//  AddTodoModel.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/28.
//

import Foundation

protocol AddTodoModelDelegate: AnyObject {
    func onSuccess()
    func onError(with message: String)
}

final class AddTodoModel {
    
    private let provider: UserDefaultsProviderProtocol
    
    weak var delegate: AddTodoModelDelegate?
    
    init(provider: UserDefaultsProviderProtocol = UserDefaultsProvider.shared) {
        self.provider = provider
    }
    
    func addTodo(title: String, detail: String?) {
        let todo = Todo(title: title, detail: detail, isCompleted: false)
        
        // NOTE: タイトルが未入力の場合
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            delegate?.onError(with: "タイトルが入力されていません")
            return
        }
        
        if let storedTodos = provider.decodable(Todos.self, for: .todos) {
            let todos = Todos(items: storedTodos.items + [todo])
            
            provider.set(encodable: todos, for: .todos)
        } else {
            let todos = Todos(items: [todo])
            provider.set(encodable: todos, for: .todos)
        }
        
        delegate?.onSuccess()
    }
}
