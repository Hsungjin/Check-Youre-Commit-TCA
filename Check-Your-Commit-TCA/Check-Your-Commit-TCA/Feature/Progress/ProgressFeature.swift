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
        @Presents var modal: ModalFeature.State?
        
        var commitDay: Int = 0
        var userGoal: Int = 0
        var progressDay: Int = 0
    }
    
    enum Action {
        case modal(PresentationAction<ModalFeature.Action>)
        
        case getCommitDay
        case getCommitResponse(Int)
        
        case getUserGoal
        case getProgressDay
        
        case showModal
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getCommitDay:
                return .run { send in
                    let commitDay = await LoginManager.shared.getCommitData()
                    await send(.getCommitResponse(commitDay))
                    await send(.getUserGoal)
                    await send(.getProgressDay)
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
                
            case .showModal:
                state.modal = ModalFeature.State (
                    commitDay: state.commitDay,
                    userGoal: state.userGoal,
                    progressDay: state.progressDay)
                return .none
                
            case .modal:
                return .none
            }
        }
        .ifLet(\.$modal, action: \.modal) {
            ModalFeature()
        }
    }
}
