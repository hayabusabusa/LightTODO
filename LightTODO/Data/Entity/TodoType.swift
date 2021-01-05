//
//  TodoType.swift
//  LightTODO
//
//  Created by 山田隼也 on 2021/01/05.
//

import Foundation

enum TodoType: Int, CaseIterable {
    case uncompleted
    case completed
    
    var title: String {
        switch self {
        case .uncompleted:
            return "未完了"
        case .completed:
            return "完了済み"
        }
    }
}
