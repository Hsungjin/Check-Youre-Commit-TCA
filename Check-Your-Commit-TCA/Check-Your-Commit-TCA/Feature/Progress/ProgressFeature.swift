//
//  ProgressFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ProgressFeature {
    @ObservableState
    struct State {
        var commitDay: Int = 0
        var userGoal: Int = 0
        var progressDay: Int = 0
        var showSheet: Bool = false
    }
    
    enum Action {
        case getCommitDay
        case getCommitResponse(Int)
        
        case getUserGoal(Int)
        case getProgressDay(Int)
        
        case toggleShowSheet(Bool)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getCommitDay:
                return .run { send in
                    let commitDay = await LoginManager.shared.getCommitData()
                    await send(.getCommitResponse(commitDay))
                }
                
            case let .getCommitResponse(input):
                state.commitDay = input
                return .none
                
            case .getUserGoal:
                state.userGoal = UserDefaults.standard.getUserGoal()
                return .none
                
            case .getProgressDay:
                state.progressDay = state.userGoal
                return .none
                
            case let .toggleShowSheet(input):
                state.showSheet = input
                return .none
            }
        }
    }
}
