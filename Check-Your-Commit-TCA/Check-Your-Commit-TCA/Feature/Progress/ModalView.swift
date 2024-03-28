//
//  ModalView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.


import SwiftUI

struct ModalView: View {
    @Binding var commitDay: Int
    @Binding var progress: Int
    @Binding var showSheet: Bool
    
    @State var goalDay = 0
    
    var body: some View {
        VStack {
            Picker("Your D-day", selection: $goalDay) {
                ForEach(1...365, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.wheel)
            Button {
                showSheet = false
                moveDinosaur()
                UserDefaults.standard.setUserGoal(goalDay)
            } label: {
                Text("저장")
                    .font(.pretendardBold_17)
                    .foregroundStyle(Color.baseColor)
            }
        }
        .presentationDetents([ .medium, .large])
        .presentationBackground(.thinMaterial)
        .onAppear {
            goalDay = UserDefaults.standard.getUserGoal()
        }
    }
    
    // Animation에 대한 함수는 뷰에서만 정의 가능
    func moveDinosaur() {
        Task {
            for i in 0...commitDay {
                try await Task.sleep(until: .now.advanced(by: .milliseconds(40)), clock: .continuous)
                withAnimation {
                    progress = i
                }
            }
        }
    }
}
