//
//  MainFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct MainFeature {
    @ObservableState
    struct State {
        @Presents var setting: SettingFeature.State?
        @Presents var todo: TodoFeature.State?
        
        var progress = ProgressFeature.State()
    }
    
    enum Action {
        case setting(PresentationAction<SettingFeature.Action>)
        case todo(PresentationAction<TodoFeature.Action>)
        
        case progress(ProgressFeature.Action)
        
        case settingButtonTapped
        case todoButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.progress, action: \.progress) {
            ProgressFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .settingButtonTapped:
                state.setting = SettingFeature.State()
                return .none
                
            case .todoButtonTapped:
                state.todo = TodoFeature.State()
                return .none
                
            case .setting(_):
                return .none
                
            case .progress(_):
                return .none
                
            case .todo(_):
                return .none
            }
        }
        .ifLet(\.$setting, action: \.setting) {
            SettingFeature()
        }
        .ifLet(\.$todo, action: \.todo) {
            TodoFeature()
        }
    }
}
