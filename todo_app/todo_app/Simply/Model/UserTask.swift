//
//  UserTask.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI

//Identifiableプロトコル : 配列をForEachで取り出すため
struct Task: Identifiable, Equatable{
//  Identifiableの構造体は idプロパティ が必須
    let id = UUID() // UUID : 自動で一意のIDを割り当てる
    var title: String
    var checked: Bool
    
    init(title: String, checked: Bool) {
        self.title = title
        self.checked = checked
    }
}
