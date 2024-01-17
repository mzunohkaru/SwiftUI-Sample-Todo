//
//  EditView.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/17.
//

import SwiftUI

struct EditView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    var todo: Todo_Entities
    
    @State var textFieldText = ""
    
    var body: some View {
        VStack {
            Text(todo.todo!)
            HStack {
                TextField("Aa", text: $textFieldText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(Capsule())
                    .onSubmit {
                        updateTodo(todo: todo)
                    }
            }
            .padding()
        }
    }
    
    private func updateTodo(todo: FetchedResults<Todo_Entities>.Element) {
        todo.todo = textFieldText
        todo.createdAt = dateFormat()
        
        save()
        
        self.presentation.wrappedValue.dismiss()
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
    }

    private func dateFormat() -> String{
        let formatter = DateFormatter()
        // 入力するフォーマット
        formatter.dateFormat = "yyy年MM月dd日 HH時mm分ss秒"
        let formattedDateString = formatter.string(from: Date())
        return formattedDateString
    }

}
