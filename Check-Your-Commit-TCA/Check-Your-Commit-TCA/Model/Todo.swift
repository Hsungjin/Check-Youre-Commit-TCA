//
//  Todo.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import RealmSwift
import SwiftUI

class TodoModel: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String = ""
    @Persisted var createAt: Date = Date()
    @Persisted var completed: Bool = false
    
    convenience init(id: ObjectId, title: String, createAt: Date, completed: Bool) {
        self.init()
        self.id = id
        self.title = title
        self.createAt = createAt
        self.completed = completed
    }
}
