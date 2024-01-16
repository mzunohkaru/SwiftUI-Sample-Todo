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
    @Environment(\.managedObjectContext) var viewContext
    
    // データを要求する
    @FetchRequest(
        // 取得したデータの並び順を指定できる
        sortDescriptors: [])
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
                        HStack {
                            todo.checked
                            ? Image(systemName: "checkmark.square")
                            : Image(systemName: "square")
                            Button(action: {
                                todo.checked.toggle()
                                checkedTodo(checkedTodo: todo.checked)
                            })
                            {
                                Text(todo.todo!)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("CoreData TODO"))
            .navigationBarItems(trailing: Button(action: deleteTodo){
                Text("Remove to Todo")
            })
        }
    }
    
    func addTodo() {
        let newTodo = Todo_Entities(context: viewContext)
        newTodo.todo = todoText
        newTodo.checked = false
        
        save()
        
        todoText = ""
    }
    
    func checkedTodo(checkedTodo: Bool) {
        let newChecked = Todo_Entities(context: viewContext)
        newChecked.checked = checkedTodo
        
        save()
    }
    
    func deleteTodo() {
        for todo in todos {
            if(todo.checked) {
                viewContext.delete(todo)
            }
        }
        
        save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
    }
}
