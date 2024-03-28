//
//  ModalFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/29/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ModalFeature {
    @ObservableState
    struct State {
        var commitDay: Int
        var userGoal: Int
        var progressDay: Int
        var showSheet: Bool
    }
    
    enum Action {
        case moveDinosour
        
        case setUserGoal(Int)
        
        case toggleShowSheet
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .moveDinosour:
                return .none
                
            case let .setUserGoal(input):
                state.userGoal = input
                return .none
                
            case .toggleShowSheet:
                state.showSheet = false
                return .none
            }
        }
    }
}
