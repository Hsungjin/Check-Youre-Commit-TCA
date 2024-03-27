//
//  SettingFeature.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SettingFeature {
    @ObservableState
    struct State: Equatable {
        var setting: IdentifiedArrayOf<SettingModel> = []
    }
    
    enum Action {
        case getSetting
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getSetting:
                state.setting = [
                    SettingModel(id: UUID(), name: "CYC에 대해서", imageName: "about", destination: { AnyView(AboutView()) }),
                    SettingModel(id: UUID(), name: "알림설정", imageName: "bells", destination: { AnyView(NotificationView()) }),
                    SettingModel(id: UUID(), name: "라이센스", imageName: "docs", destination: { AnyView(LicenseView()) })
                ]
                return .none
                
            }
        }
    }
}
