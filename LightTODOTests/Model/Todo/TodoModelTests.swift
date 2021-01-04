//
//  TodoModelTests.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2021/01/04.
//

import XCTest
@testable import LightTODO

class TodoModelTests: XCTestCase {
    
    func testOnSuccess() {
        let todos = Todos(items: [
            Todo(id: "ID", title: "TEST", detail: "TEST", isCompleted: true)
        ])
        let provider = MockUserDefaultsProvider<Todos>(stored: todos)
        let model = TodoModel(provider: provider)
        let receiver = TodoModelReceiver()
        
        model.delegate = receiver
        model.removeTodo(of: "NOT CALLED")
        
        XCTAssertFalse(receiver.isCalledOnSuccess)
        
        model.removeTodo(of: "ID")
        
        XCTAssertTrue(receiver.isCalledOnSuccess)
    }
}
