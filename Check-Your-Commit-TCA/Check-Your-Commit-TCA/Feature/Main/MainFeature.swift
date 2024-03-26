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
        var loginState: Bool = false
    }
    
    enum Action {
        case getLoginState
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getLoginState:
                state.loginState = UserDefaults.standard.getLoginState()!
                return .none
            }
        }
    }
}
