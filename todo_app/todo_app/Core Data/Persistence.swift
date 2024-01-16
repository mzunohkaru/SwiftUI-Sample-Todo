//
//  Persistence.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    // PersistenceControllerインスタンスが作成されたときに呼ばれる
    init() {
        container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores(completionHandler: {
            // PersistentStoreの読み込み又は作成時に実行する処理
            // storeDescription : NSPersistentStoreDescription型
            (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
