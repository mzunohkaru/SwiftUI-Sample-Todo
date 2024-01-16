//
//  UserData.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI


class UserData: ObservableObject {
    //  @Published : 監視するプロパティを設定
    @Published var tasks = [
        Task(title: "programing", checked: true),
        Task(title: "eat", checked: false),
        Task(title: "study", checked: true),
    ]
    
    @Published var isEditing: Bool = false
    @Published var isShowSheet: Bool = false
}
