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
    static let store = Store(initialState: MainFeature.State()) {
      MainFeature()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView(store: Check_Your_Commit_TCAApp.store)
        }
    }
}
