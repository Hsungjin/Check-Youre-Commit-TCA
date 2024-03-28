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
    
    @State var showSheet = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ProgressTextView(commitDay: $store.commitDay.sending(\.getCommitResponse))
            
            HStack(alignment: .center) {
                ProgressBarView(progress: $store.progressDay.sending(\.getProgressDay),
                                goal: $store.userGoal.sending(\.getUserGoal))
//                .onAppear {
//                    ModalView(commitDay: $store.commitDay.sending(\.getCommitResponse),
//                              goalDay: $store.userGoal.sending(\.getUserGoal),
//                              progress: $store.progressDay.sending(\.getProgressDay)).moveDinosaur()
//                }
//                
                //                 pink dinosaur button view
                ZStack(alignment: .top) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        DdayButtonView(goal: $store.userGoal.sending(\.getUserGoal))
                    }
                    .tint(.clear)
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $showSheet) {
                        ModalView(commitDay: $store.commitDay.sending(\.getCommitResponse),
                                  progress: $store.progressDay.sending(\.getProgressDay),
                                  showSheet: $showSheet)
                    }
                    .onDisappear {
                        store.send(.getCommitDay)
                        store.send(.getUserGoal(0))
                        store.send(.getProgressDay(0))
                    }
                }
                .padding(.top, -15)
            }
            .padding(.horizontal, 5)
        }
        .padding(.top, 20)
        .background(Color.bgColor)
        .onAppear {
            store.send(.getCommitDay)
            store.send(.getUserGoal(0))
            store.send(.getProgressDay(0))
        }
    }
}

