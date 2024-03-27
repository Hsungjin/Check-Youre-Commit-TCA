//
//  ProgressTextView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct ProgressTextView: View {
    @Binding var commitDay: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: -10) {
            Text("커밋 챌린지 \(commitDay)일째\n")
                .font(.pretendardBold_17)
            
            Text("너 만나러 커밋 하는 중...")
                .font(.pretendardSemiBold_15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
}
