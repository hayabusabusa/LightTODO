//
//  AddTodoModelReceiver.swift
//  LightTODOTests
//
//  Created by 山田隼也 on 2020/12/28.
//

import Foundation
@testable import LightTODO

class AddTodoModelReceiver: AddTodoModelDelegate {
    
    var isCalledOnSuccess = false
    var errorMessage: String?
    
    func onSuccess() {
        isCalledOnSuccess = true
    }
    
    func onError(with message: String) {
        errorMessage = message
    }
}
