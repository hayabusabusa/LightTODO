//
//  AddTodoModelTests.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/28.
//

import XCTest
@testable import LightTODO

class AddTodoModelTests: XCTestCase {

    func testAddTodoWithContents() {
        let todos = Todos(items: [])
        let provider = MockUserDefaultsProvider<Todos>(stored: todos)
        let model = AddTodoModel(provider: provider)
        let receiver = AddTodoModelReceiver()
        
        model.delegate = receiver
        model.addTodo(title: "TEST", detail: "TEST")
        
        XCTAssertTrue(receiver.isCalledOnSuccess)
        
        let storedTodos = provider.decodable(Todos.self, for: .todos)
        XCTAssertNotNil(storedTodos?.items.first)
        XCTAssertEqual(storedTodos?.items.first?.title, "TEST")
        XCTAssertEqual(storedTodos?.items.first?.detail, "TEST")
    }
    
    func testAddTodoError() {
        let todos = Todos(items: [])
        let provider = MockUserDefaultsProvider<Todos>(stored: todos)
        let model = AddTodoModel(provider: provider)
        let receiver = AddTodoModelReceiver()
        
        model.delegate = receiver
        model.addTodo(title: "", detail: "TEST")
        
        XCTAssertNotNil(receiver.errorMessage)
    }
}
