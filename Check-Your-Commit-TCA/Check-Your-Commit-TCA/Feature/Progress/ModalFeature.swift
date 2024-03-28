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
    }
    
    enum Action {
        case setUserGoal(Int)
        case closeSheet
    }
    
    @Dependency(\.dismiss) var dismiss
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setUserGoal(input):
                state.userGoal = input
                return .none
                
            case .closeSheet:
                return .run { _ in await self.dismiss() }
            }
        }
    }
}
