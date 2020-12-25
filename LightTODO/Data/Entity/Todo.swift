//
//  Todo.swift
//  LightTODO
//
//  Created by 山田隼也 on 2020/12/25.
//

import Foundation

struct Todo: Encodable {
    let title: String
    let detail: String?
    let isCompleted: Bool
}
