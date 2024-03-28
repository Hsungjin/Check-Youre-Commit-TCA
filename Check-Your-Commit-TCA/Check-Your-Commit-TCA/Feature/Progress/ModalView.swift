//
//  ModalView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.

import ComposableArchitecture
import SwiftUI

struct ModalView: View {
    @Bindable var store: StoreOf<ModalFeature>
    
    var body: some View {
        VStack {
            Picker("Your D-day", selection: $store.userGoal.sending(\.setUserGoal)) {
                ForEach(1...365, id: \.self) { number in
                    Text("\(number)")
                }
            }
            .pickerStyle(.wheel)
            Button {
                UserDefaults.standard.setUserGoal(store.userGoal)
                store.send(.closeSheet)
//                moveDinosaur()
            } label: {
                Text("저장")
                    .font(.pretendardBold_17)
                    .foregroundStyle(Color.baseColor)
            }
        }
        .presentationDetents([ .medium, .large])
        .presentationBackground(.thinMaterial)
    }
    
    // Animation에 대한 함수는 뷰에서만 정의 가능
//    func moveDinosaur() {
//        Task {
//            for i in 0...store.commitDay {
//                try await Task.sleep(until: .now.advanced(by: .milliseconds(40)), clock: .continuous)
//                withAnimation {
//                    store.send(.changeProgressDay(i))
//                }
//            }
//        }
//    }
}
