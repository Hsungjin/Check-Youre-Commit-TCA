//
//  LisenseView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/27/24.
//

import SwiftUI

struct LicenseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let licenseInfo:[LicenseModel] = [
        LicenseModel(text: "이모티콘: Desingned by Flaticon", destination: "https://www.flaticon.com/kr/free-icon/birthday_817754?term=%EA%B3%B5%EB%A3%A1&page=1&position=10&origin=search&related_id=817754"),
        LicenseModel(text: "폰트: Pretendard", destination: "https://cactus.tistory.com/306"),
    ]
    
    var backButton : some View {  // <-- 👀 커스텀 버튼
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
        ZStack {
            Color.bgColor.ignoresSafeArea(.all)
            VStack(alignment: .leading) {
                // MARK: - 해더
                Text("라이센스")
                    .font(.pretendardBold_23)
                    .padding(.bottom, 5)
                Text("터치 시 라이센스 링크로 연결합니다")
                    .font(.pretendardLight_11)
                    .padding(.bottom, 20)
                
                // MARK: - 스크롤뷰(라이센스 링크)
                ForEach(licenseInfo) { info in
                    Link("\(info.text)", destination: URL(string: "\(info.destination)")!)
                        .font(.pretendardSemiBold_15)
                        .padding(.bottom, 15)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.baseColor)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 5)
            
        }
        .navigationTitle("라이센스")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
}
