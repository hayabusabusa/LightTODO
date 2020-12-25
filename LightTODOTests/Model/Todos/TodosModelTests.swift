//
//  TodosModelTests.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/25.
//

import XCTest
@testable import LightTODO

class TodosModelTests: XCTestCase {

    func testGetTodos() {
        let todos = Todos(items: [
            Todo(title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        model.getTodos()
        
        XCTAssertEqual(receiver.todos.count, 1)
    }
}
