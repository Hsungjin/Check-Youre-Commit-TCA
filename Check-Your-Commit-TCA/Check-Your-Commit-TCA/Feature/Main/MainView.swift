//
//  MainView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    let store: StoreOf<MainFeature>
    
    var body: some View {
        ZStack {
            if !store.loginState {
                LoginView(store: Store(initialState: LoginFeature.State()) {
                    LoginFeature()
                })
            } else if store.loginState {
                HStack {
                    Image(systemName: "bolt")
                        .frame(width: 100, height: 100)
                }
            }
        }
        .onAppear {
            store.send(.getLoginState)
        }
    }
}
