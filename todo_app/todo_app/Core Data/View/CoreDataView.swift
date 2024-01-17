//
//  CoreDataView.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI
import CoreData

struct CoreDataView: View {
    
    // Environment ValueをmanagedObjectContextパスから取得し、値をviewContextに格納する
    @Environment(\.managedObjectContext) private var viewContext
    
    // データを要求する
    @FetchRequest(
        // 取得したデータの並び順を指定できる
        sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)])
    // FetchRequestで取得したデータを格納する
    var todos: FetchedResults<Todo_Entities> // FetchedResults< [Entity名] >
    
    @State var todoText = ""
    
    var body: some View {
        NavigationView {
            List {
                TextField("Plese Enter Todo", text: $todoText)
                    .onSubmit {
                        addTodo()
                    }
                
                ForEach(todos) { todo in
                    if (todo.todo?.isEmpty) == false {
                        NavigationLink(destination: EditView(todo: todo)){
                            HStack {
                                Image(systemName: todo.checked ?"checkmark.square" :"square")
                                    .onTapGesture {
                                        todo.checked.toggle()
                                        checkedTodo(checkedTodo: todo.checked)
                                        save()
                                    }
                                VStack(spacing: 12) {
                                    Text(todo.todo!)
                                    Text(todo.createdAt!)
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                            }
                        }
                    }
                }
                // スワイプ削除
                .onDelete(perform: deleteTodoList)
            }
            .navigationBarTitle(Text("CoreData TODO"))
            .navigationBarItems(trailing: Button(action: deleteTodo){
                Text("Remove to Todo")
            })
        }
    }
    
    private func addTodo() {
        let newTodo = Todo_Entities(context: viewContext)
        newTodo.todo = todoText
        newTodo.createdAt = dateFormat()
        
        save()
        
        todoText = ""
    }
    
    private func checkedTodo(checkedTodo: Bool) {
        let newChecked = Todo_Entities(context: viewContext)
        newChecked.checked = checkedTodo
        
        save()
    }
    
    private func deleteTodoList(offsets: IndexSet) {
        offsets.forEach { index in
            viewContext.delete(todos[index])
        }
        save()
    }
    
    private func deleteTodo() {
        for todo in todos {
            if(todo.checked) {
                viewContext.delete(todo)
            }
        }
        
        save()
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
