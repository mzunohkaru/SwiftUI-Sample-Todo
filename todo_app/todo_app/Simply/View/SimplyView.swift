//
//  SimplyView.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/16.
//

import SwiftUI

struct SimplyView: View {
    
    //  UserData()のtasksプロパティが変更されると、Viewの更新もする
    @EnvironmentObject var userData: UserData
    
    @State var isShowAlert = false
    @State var isShowDialog = false
    @State var isShowSheet = false
    
    var body: some View {
        NavigationView {
            List{
                // userData.tasksの要素を表示する
                ForEach(userData.tasks) { task in
                    Button(action: {
                        checkBox(task: task)
                    }) {
                        ListRow(task: task.title, isCheck: task.checked)
                    }
                }
                Button(action: {
                    self.userData.isShowSheet = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
            
            .navigationBarTitle(Text("Simply TODO"))
            .navigationBarItems(leading:
                                    Button(action: {
                isShowDialog = true
            }){
                Image(systemName: "platter.filled.bottom.and.arrow.down.iphone")
            })
            .navigationBarItems(trailing: Button(action: {
                isShowAlert = true
            }){
                Text("Delete")
            })
            // アラート
            .alert("Alert Title", isPresented: $isShowAlert) {
                Button("Delete", role: .destructive){
                    deleteTask()
                }
                Button("Cansel", role: .cancel){}
            } message: {
                Text("Alert Message")
            }
            // ダイアログ
            .confirmationDialog("Dialog Title", isPresented: $isShowDialog) {
                ForEach(userData.tasks) { task in
                    Button(task.title){
                        checkBox(task: task)
                    }
                }
                Button("Cansel", role: .cancel){}
            } message: {
                Text("Dialog Message")
            }
            // Sheet
            .sheet(isPresented: $userData.isShowSheet) {
                Draft()
                    .presentationDetents([.height(90)])
            }
        }
    }
    
    private func checkBox(task: Task) {
        // タップしたuserData.tasksの要素番号（firstIndexはオプショナル型）を返す
        guard let index = self.userData.tasks.firstIndex(of: task) else{
            // 要素番号が null の場合
            return
        }
        // toggle() : checked = !checked
        self.userData.tasks[index].checked.toggle()
    }
    
    private func deleteTask() {
        // filter : 配列から引数の条件に一致する要素だけが格納された配列を返す
        let necessaryTask = self.userData.tasks.filter({!$0.checked})
        self.userData.tasks = necessaryTask
    }
}

struct SimplyView_Previews: PreviewProvider {
    static var previews: some View {
        SimplyView()
            .environmentObject(UserData()) // UserData() を @EnvironmentObjec として使えるようにする
    }
}

