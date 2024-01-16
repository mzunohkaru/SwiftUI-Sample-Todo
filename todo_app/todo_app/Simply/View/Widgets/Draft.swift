//
//  Draft.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI

struct Draft: View {
    @State var taskTitle = ""
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        TextField("Please Enter task", text: $taskTitle)
            .onSubmit {
                self.createTask()
                self.userData.isEditing = false
                self.userData.isShowSheet = false
            }
            .padding()
    }
    
    func createTask() {
        let newTask = Task(title: self.taskTitle, checked: false)
        self.userData.tasks.insert(newTask, at: 0)
        self.taskTitle = ""
    }
}

struct Draft_Previews: PreviewProvider {
    static var previews: some View {
        Draft()
    }
}
