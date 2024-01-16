//
//  ListRow.swift
//  todo_app
//
//  Created by Mizuno Hikaru on 2024/01/09.
//

import SwiftUI

struct ListRow: View {
    let task: String
    var isCheck: Bool
    
    var body: some View {
        HStack{
            //            isCheck ? Image(systemName: "circle") : Image(systemName: "checkmark.circle.fill")
            
            if (isCheck){
                Image(systemName: "checkmark.circle.fill")
                Text(task)
                    .strikethrough()
                    .fontWeight(.ultraLight)
            }
            else
            {
                Image(systemName: "circle")
                Text(task)
            }
            
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow(task: "TEST", isCheck: true)
    }
}
