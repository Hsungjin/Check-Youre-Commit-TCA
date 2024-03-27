//
//  SettingView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import ComposableArchitecture
import SwiftUI

struct SettingView: View {
    @Bindable var store: StoreOf<SettingFeature>
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("isLoggedIn") var isloggedInVIew: Bool = true
    
    @State private var showingAlert = false
    
    var backButton : some View {
        Button{
            dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left") // 화살표 Image
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.gray)
                    .bold()
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.bgColor.ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    // MARK: - 헤더
                    Text("설정")
                        .font(.pretendardBold_23)
                        .padding(.horizontal, 15)
                    
                    // MARK: - 설정
                    VStack(alignment: .leading) {
                        ForEach(store.setting, id: \.self) { setting in
                            NavigationLink(destination: setting.destination) {
                                HStack {
                                    Image("\(setting.imageName)")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                    Text("\(setting.name)")
                                        .font(.pretendardMedium_17)
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                }
                                .foregroundStyle(.base)
                                .padding(.vertical, 8)
                            }
                            
                        }
                        
                        // MARK: - 로그아웃
                        Button {
                            showingAlert.toggle()
                        } label: {
                            HStack(spacing: 18) {
                                Image("trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                
                                Text("로그아웃")
                            }
                            .font(.pretendardMedium_17)
                            .foregroundStyle(.logout)
                            .padding(.top, 8)
                        }
                        .alert("정말 로그아웃 하시겠어요?", isPresented: $showingAlert) {
                            Button("로그아웃", role: .destructive) {
                                //                                    loginModel.logout()
                                isloggedInVIew = false
                            }
                            
                            Button("닫기", role: .cancel) {
                                showingAlert = false
                            }
                        }
                    }
                    .padding(.leading, 15)
                    .padding(.horizontal, 10)
                    
                    // MARK: - Powered by PJ2T2_CYC
                    Spacer()
                    Text("2024, Check Your Commit all rights reserved.")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.pretendardLight_11)
                    Text("Powered by PJ2T2_CYC")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.pretendardLight_11)
                }
                
            }
            .navigationTitle("설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .onAppear {
                store.send(.getSetting)
            }
        }
    }
}
    
