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
    }
    
    enum Action {
        case getCommitDay
        case getCommitResponse(Int)
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
            }
        }
    }
}
