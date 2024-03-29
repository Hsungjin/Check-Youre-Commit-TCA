//
//  TodoFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TodoFeature {
    @ObservableState
    struct State: Equatable {
        var sortedTodoModel: [TodoModel] = []
        var textField: String = ""
        var isTextFieldShowing: Bool = false
    }
    
    enum Action {
        case getTodoList(TodoCase)
        case textFieldChange(String)
        case testFieldShowing(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case let .getTodoList(input):
                switch input {
                case .main:
                    state.sortedTodoModel = RealmManager.shared.getSortedTodoList(type: .main)
                    return .none
                    
                case .preview:
                    state.sortedTodoModel = RealmManager.shared.getSortedTodoList(type: .preview)
                    return .none
                }
                
            case let .textFieldChange(input):
                state.textField = input
                return .none
                
            case let .testFieldShowing(input):
                state.isTextFieldShowing = input
                return .none
            }
        }
    }
}
