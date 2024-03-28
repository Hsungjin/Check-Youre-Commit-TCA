//
//  GrassView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import GrassView
import SwiftUI

struct CommitView: View {
    @State var test: [String: Int] = [:]
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.containerColor)
                .cornerRadius(15.0)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            
            
            VStack(alignment: .leading) {
                Text("커밋 기록")
                    .font(.pretendardBold_17)
                    .foregroundStyle(.base)
                    .padding(.bottom, 10)
                ZStack {
                    GrassView(test, row: 4, col: 10, cellColor: .green)
                    RoundedRectangle(cornerRadius: 15.0)
                        .foregroundStyle(Color(white: 1.0, opacity: 0.001))
                        .padding(.horizontal, 10)
                }
//                .gesture(
//                    TapGesture()
//                        .onEnded { _ in
//                            commitModel.showColorModal.toggle()
//                        })
//                .sheet(isPresented: $commitModel.showColorModal) {
//                    ColorModalView()
//                }
            }
            .padding(40)
        }
        .onAppear {
            Task {
                let _ = await LoginManager.shared.getCommitData()
                test = LoginManager.shared.testCase
            }
        }
    }
}
