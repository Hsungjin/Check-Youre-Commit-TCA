//
//  Setting.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct SettingModel: Identifiable, Hashable {
    let id: UUID
    let name: String
    let imageName: String
    let destination: () -> AnyView
    
    // MARK: - Equatable 프로토콜
    static func == (lhs: SettingModel, rhs: SettingModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    // MARK: - Hashable 프로토콜
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
