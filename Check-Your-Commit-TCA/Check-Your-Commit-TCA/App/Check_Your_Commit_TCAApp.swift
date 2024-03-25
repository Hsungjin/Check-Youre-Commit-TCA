//
//  Check_Your_Commit_TCAApp.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI

@main
struct Check_Your_Commit_TCAApp: App {
    static let store = Store(initialState: LoginFeature.State()) {
      LoginFeature()
    }
    
    
    var body: some Scene {
        WindowGroup {
            LoginView(store: Check_Your_Commit_TCAApp.store)
        }
    }
}
