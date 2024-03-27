//
//  EnterView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//
import ComposableArchitecture
import SwiftUI

struct EnterView: View {
    @AppStorage("isLoggedIn") var isloggedInVIew: Bool = false

    var body: some View {
        ZStack {
            if !isloggedInVIew {
                LoginView()
            } else {
                MainView(store: Store(initialState: MainFeature.State()) {
                    MainFeature()
                })
            }
        }
    }
}
