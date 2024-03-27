//
//  ProgressView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI

struct ProgressView: View {
    @Bindable var store: StoreOf<ProgressFeature>
    
    var body: some View {
        VStack {
            ProgressTextView(commitDay: $store.commitDay.sending(\.getCommitResponse))
//            HStack(alignment: .center) {
//                ProgressBarView()
//                    .onAppear {
//                        progressModel.progress = loginModel.commitDay
//                        ModalView().moveDinosaur()
//                    }
//                
//                // pink dinosaur button view
//                ZStack(alignment: .top) {
//                    Button {
//                        progressModel.showSheet.toggle()
//                    } label: {
//                        DdayButtonView(goal: $progressModel.goal)
//                    }
//                    .tint(.clear)
//                    .buttonStyle(.borderedProminent)
//                    .sheet(isPresented: $progressModel.showSheet) {
//                        ModalView()
//                    }
//                }
//                .padding(.top, -15)
//            }
//            .padding(.horizontal, 5)
        }
        .padding(.top, 20)
        .background(Color.bgColor)
        .onAppear {
            store.send(.getCommitDay)
        }
    }
}

