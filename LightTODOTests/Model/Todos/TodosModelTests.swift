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
            Todo(id: "TEST", title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        model.getTodos()
        
        XCTAssertEqual(receiver.todos.count, 1)
    }
    
    func testToggleTodo() {
        let todos = Todos(items: [
            Todo(id: "ID", title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        model.getTodos()
        
        XCTContext.runActivity(named: "存在しない ID の場合は何も変化していないことを確認") { _ in
            model.toggleTodo(of: "TEST")
            model.getTodos()
            
            XCTAssertEqual(receiver.todos.first?.isCompleted, false)
        }
        
        XCTContext.runActivity(named: "存在する ID の場合は `isCompleted` が `true` になることを確認") { _ in
            model.toggleTodo(of: "ID")
            model.getTodos()
            
            XCTAssertEqual(receiver.todos.first?.isCompleted, true)
        }
    }
}
