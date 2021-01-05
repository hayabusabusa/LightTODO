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
            Todo(id: "TEST0", title: "TEST", detail: "TEST", isCompleted: false),
            Todo(id: "TEST1", title: "TEST", detail: "TEST", isCompleted: true)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        
        XCTContext.runActivity(named: "未完了の TODO 一覧が取得できることを確認") { _ in
            model.getTodos(of: .uncompleted)
            
            XCTAssertEqual(receiver.todos.count, 1)
        }
        
        XCTContext.runActivity(named: "完了済みの TODO 一覧が取得できることを確認") { _ in
            model.getTodos(of: .completed)
            
            XCTAssertEqual(receiver.todos.count, 1)
        }
    }
    
    func testToggleTodoCategory() {
        let todos = Todos(items: [
            Todo(id: "ID", title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        model.toggleTodoCategory(to: .completed)
        
        XCTAssertEqual(receiver.todos.count, 0)
        
        model.toggleTodoCategory(to: .uncompleted)
        
        XCTAssertEqual(receiver.todos.count, 1)
    }
    
    func testToggleTodo() {
        let todos = Todos(items: [
            Todo(id: "ID", title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let model = TodosModel(provider: MockUserDefaultsProvider<Todos>(stored: todos))
        let receiver = TodosModelReceiver()
        
        model.delegate = receiver
        model.getTodos(of: .uncompleted)
        
        XCTContext.runActivity(named: "存在しない ID の場合は何も変化していないことを確認") { _ in
            model.toggleTodo(of: "TEST")
            model.getTodos(of: .uncompleted)
            
            XCTAssertEqual(receiver.todos.first?.isCompleted, false)
        }
        
        XCTContext.runActivity(named: "存在する ID の場合は `isCompleted` が `true` になることを確認") { _ in
            model.toggleTodo(of: "ID")
            model.getTodos(of: .completed)
            
            XCTAssertEqual(receiver.todos.first?.isCompleted, true)
        }
    }
}
