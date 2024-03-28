//
//  MainView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    @Bindable var store: StoreOf<MainFeature>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgColor.ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    // MARK: - 네비게이션 타이틀
                    HStack {
                        Image("logo1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 55)
                        
                        Spacer()
                        //
                        //                        // DL Mode
                        //                        Button {
                        //                            withAnimation {
                        //                                show.toggle()
                        //                            }
                        //                        } label: {
                        //                            Image(systemName: "lamp.table.fill")
                        //                                .resizable()
                        //                                .scaledToFit()
                        //                                .frame(width: 25, height: 25)
                        //                                .foregroundStyle(.gray)
                        //                                .padding(.horizontal, 5)
                        //                        }
                        //
                        Button {
                            store.send(.settingButtonTapped)
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical)
                    
                    ScrollView {
                        // MARK: - 상단 텍스트
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Hi, \(UserDefaults.standard.getUserName() ?? "CYC")")
                            
                            Text("오늘 커밋 잡쉈어?")
                            
                            HStack {
                                Spacer()
                            }
                        }
                        .font(.pretendardBold_25)
                        .padding(.leading, 25)
                        
                        // MARK: - 하단 뷰 연결
                        ProgressView(store: store.scope(state: \.progress, action: \.progress))
                        
                        // MARK: - 잔디 뷰 연결
                        CommitView()
                            .padding(.top, -15)
                        
                        // MARK: - 알림장 미리보기
                        //                        TodoView(store: store.scope(state: \.todo, action: \.todo))
                        TodoPreView()
                            .onTapGesture {
                                store.send(.todoButtonTapped)
                            }
                    }
                    .scrollIndicators(.hidden)
                }
                //                DLMode(appearanceMode: $appearanceMode, show: $show)
                //                    .ignoresSafeArea()
            }
            .navigationDestination(
                item: $store.scope(state: \.setting, action: \.setting)
            ) { settingStore in
                SettingView(store: settingStore)
            }
            .navigationDestination(
                item: $store.scope(state: \.todo, action: \.todo)
            ) { todoStore in
                TodoView(store: todoStore)
            }
        }
        //        .onAppear() {
        //            loginModel.getCommitData()
        //        }
    }
}
