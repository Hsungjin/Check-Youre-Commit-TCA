//
//  BackButtonView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View { // 커스텀 버튼
        Button{
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.gray)
                    .bold()
            }
        }
    }
}
