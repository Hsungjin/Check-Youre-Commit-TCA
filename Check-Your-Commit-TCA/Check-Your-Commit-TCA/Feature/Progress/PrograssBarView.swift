//
//  PrograssBarView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct ProgressBarView: View {
    //    @AppStorage("colorkey") var selectedColor: Color = .green
    
    @Binding var progress: Int
    @Binding var goal: Int
    
    var maxProgressWidth: Double {
        let containerWidth = UIScreen.main.bounds.width - 95
        let progressWidth = CGFloat(Double(progress) / Double(goal)) * containerWidth
        return min(progressWidth, containerWidth)
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 60)
                .foregroundColor(.bgColor)
            
            RoundedRectangle(cornerRadius: 60)
                .fill(Color.white)
                .frame(height: 4)
                .offset(x: 2, y: 0)
            
            // 색깔 그래프, 공룡 이미지 부분
            RoundedRectangle(cornerRadius: 60)
                .foregroundColor(.green)
                .frame(height: 4)
            //progress bar 움직이는 이미지
                .overlay(
                    Image(.kissGreen)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .offset(x: 20, y: 0)
                    ,alignment: .trailing
                )
            // min 값을 줘야 0 ~ commitday까지 그래프 애니메이션 표시 가능
                .frame(width: maxProgressWidth)
                .fixedSize()
        }
        .offset(x: 20, y: 6)
        .padding(.trailing, 10)
    }
}
