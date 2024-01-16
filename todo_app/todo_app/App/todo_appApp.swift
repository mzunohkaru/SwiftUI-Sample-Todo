//
//  todo_appApp.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI

@main
struct todo_appApp: App {
    // Container作成
    let persistenceController = PersistenceController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserData())
            // Environment Value (ContentView()のViewが保持している値) に値を格納するモディファイア
                .environment(
                    // Environment Valueのパス
                    \.managedObjectContext,
                     // Environment Valueに格納する値 (作成したcontainerのContext)
                     persistenceController.container.viewContext)
        }
    }
}
