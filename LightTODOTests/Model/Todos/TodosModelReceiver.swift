//
//  TodosModelReceiver.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/26.
//

import Foundation
@testable import LightTODO

class TodosModelReceiver: TodosModelDelegate {
    private(set) public var todos: [Todo] = []
    
    func onSuccess(todos: [Todo]) {
        self.todos = todos
    }
}
