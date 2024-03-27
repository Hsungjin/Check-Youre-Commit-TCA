//
//  DdayBUttonView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct DdayButtonView: View {
    @Binding var goal: Int
    
    var body: some View {
        VStack {
            Text("D-\(goal)")
                .font(.pretendardSemiBold_12)
                .foregroundStyle(Color.baseColor)

            Image(.kissPink)
                .resizable()
                .scaledToFit()
                .frame(width: 40)
        }
    }
}
