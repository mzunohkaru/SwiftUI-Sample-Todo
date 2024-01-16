//
//  ContentView.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI

struct ContentView: View {
    
    //画面遷移の時に使用するbool値
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                NavigationLink {
                    SimplyView()
                } label: {
                    Text("シンプルなTodoアプリ")
                }
                
                NavigationLink {
                    CoreDataView()
                } label: {
                    Text("データが永続的なTodoアプリ")
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
