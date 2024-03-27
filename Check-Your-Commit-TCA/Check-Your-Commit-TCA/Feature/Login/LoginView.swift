//
//  LoginView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") var isloggedInVIew: Bool = false

    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                    .frame(height: 100)
                
                // MARK: - 중간 온보딩 뷰
                VStack {
                    OnboardingTabView()
                }
                
                // MARK: - Github 소셜 로그인 버튼
                Link(destination: LoginManager.shared.requestCode() ?? URL(string: "")!,
                     label: {
                    Image("githubbutton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 50)
                })
                .padding()
                .onOpenURL(perform: { url in
                    Task{
                        let success = await LoginManager.shared.handleCodeFromURL(url)
                            if success{
                                await LoginManager.shared.get_access_token()
                                isloggedInVIew = true
                            }
                        }
                })

                Text("2024, Check Your Commit all rights reserved.\nPowered by 4T2F")
                    .font(.pretendardLight_11)
                    .multilineTextAlignment(.center)
            }
        }
    }
}
