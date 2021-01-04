//
//  TodosTests.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/25.
//

import XCTest
@testable import LightTODO

class TodosTests: XCTestCase {

    func testDecodingTodoEntity() {
        let json = """
        {
            "id": "TEST",
            "title": "TEST",
            "detail": "TEST",
            "isCompleted": true
        }
        """.data(using: .utf8)!
        
        let todo = try? JSONDecoder().decode(Todo.self, from: json)
        
        XCTAssertNotNil(todo)
        XCTAssertEqual(todo?.title, "TEST")
        XCTAssertEqual(todo?.detail, "TEST")
        XCTAssertEqual(todo?.isCompleted, true)
    }
    
    func testDecodingTodosEntity() {
        let json = """
        {
            "items": [
                {
                    "id": "TEST",
                    "title": "TEST",
                    "detail": "TEST",
                    "isCompleted": true
                },
                {
                    "id": "TEST",
                    "title": "TEST",
                    "detail": "TEST",
                    "isCompleted": true
                }
            ]
        }
        """.data(using: .utf8)!
        
        let todos = try? JSONDecoder().decode(Todos.self, from: json)
        
        XCTAssertNotNil(todos)
        XCTAssertEqual(todos?.items.count, 2)
    }
    
    func testEncodingTodoEntity() {
        let todo = Todo(id: "TEST", title: "TEST", detail: "TEST", isCompleted: true)
        let data = try? JSONEncoder().encode(todo)
        
        XCTAssertNotNil(data)
    }
    
    func testEncodingTodosEntity() {
        let todos = Todos(items: [
            Todo(id: "TEST", title: "TEST", detail: "TEST", isCompleted: true),
            Todo(id: "TEST", title: "TEST", detail: "TEST", isCompleted: false)
        ])
        let data = try? JSONEncoder().encode(todos)
        
        XCTAssertNotNil(data)
    }
}
