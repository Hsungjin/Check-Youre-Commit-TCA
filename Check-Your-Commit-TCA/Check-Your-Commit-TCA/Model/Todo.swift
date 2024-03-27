//
//  Todo.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import RealmSwift
import SwiftUI

struct TodoModel: Identifiable {
    var id = UUID()
    var title: String
    var createdAt = Date()
    var completed = false

    init(title: String = "") {
        self.title = title
    }
}
