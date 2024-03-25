//
//  LoginFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct LoginFeature {
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        case loginButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loginButtonTapped:
                return .none
            }
        }
    }
}
