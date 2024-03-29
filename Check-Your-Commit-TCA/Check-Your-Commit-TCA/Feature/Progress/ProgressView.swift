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
        VStack(alignment: .leading) {
            ProgressTextView(commitDay: $store.commitDay.sending(\.getCommitResponse))
            
            HStack(alignment: .center) {
                ProgressBarView()
//                .onAppear {
//                    ModalView(commitDay: $store.commitDay.sending(\.getCommitResponse),
//                              goalDay: $store.userGoal.sending(\.getUserGoal),
//                              progress: $store.progressDay.sending(\.getProgressDay)).moveDinosaur()
//                }
//                
                // pink dinosaur button view
                ZStack(alignment: .top) {
                    Button {
                        store.send(.showModal)
                    } label: {
                        VStack {
                            Text("D-\(store.userGoal)")
                                .font(.pretendardSemiBold_12)
                                .foregroundStyle(Color.baseColor)

                            Image(.kissPink)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                        }
                    }
                    .tint(.clear)
                    .buttonStyle(.borderedProminent)
                    .sheet(item: $store.scope(state: \.modal, action: \.modal)
                    ) { modalStore in
                        ModalView(store: modalStore)
                            .onDisappear {
                                store.send(.getCommitDay)
                            }
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
        }
    }
}

