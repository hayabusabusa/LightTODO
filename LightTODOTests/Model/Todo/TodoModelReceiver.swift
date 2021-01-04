//
//  TodoModelReceiver.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2021/01/04.
//

import Foundation
@testable import LightTODO

class TodoModelReceiver: TodoModelDelegate {
    
    private(set) public var isCalledOnSuccess = false
    
    func onSuccess() {
        isCalledOnSuccess = true
    }
}
