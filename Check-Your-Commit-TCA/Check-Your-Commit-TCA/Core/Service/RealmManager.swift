//
//  RealmManager.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import Foundation
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    private let realm = try! Realm()
    
    private init() { }
    
    func getSortedTodoList() -> [TodoModel] {
        let todo = realm.objects(TodoModel.self)
        let uncompletedTodos = todo.filter("completed == false").sorted(byKeyPath: "createAt", ascending: false)
        let completedTodos = todo.filter("completed == true").sorted(byKeyPath: "createAt", ascending: false)
        return Array(uncompletedTodos) + Array(completedTodos)
    }
    
    func writeTodoList(_ title: String) {
        let todo = TodoModel()
        todo.title = title
        
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print("Error Create todo item: \(error.localizedDescription)")
        }
    }
    
    func deleteTodoList(_ todo: TodoModel) {
        do {
            try realm.write {
                realm.delete(todo)
            }
        } catch {
            print("Error deleting todo item: \(error.localizedDescription)")
        }
    }
    
    func toggleCompleted(_ todoItem: TodoModel) {
        do {
            try realm.write {
                todoItem.completed.toggle()
            }
        } catch {
            print("Error toggling completion status: \(error.localizedDescription)")
        }
    }
}
