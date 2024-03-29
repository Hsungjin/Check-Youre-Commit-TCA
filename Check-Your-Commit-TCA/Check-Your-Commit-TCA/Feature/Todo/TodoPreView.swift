//
//  TodoPreView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/28/24.
//

import SwiftUI

struct TodoPreView: View {
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.containerColor)
                .frame(width: 350, height: 200)
                .cornerRadius(15.0)
            VStack(alignment: .leading) {
                // MARK: - Todo 미리보기 헤더
                HStack(spacing: 230) {
                    Text("오늘 뭐해?")
                        .font(.pretendardBold_17)
                        .foregroundStyle(.base)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.base)
                }
                .padding(.leading, 20)
                .padding(.top, 10)
                
                Divider()
                    .frame(width: 350)
                    .padding(.top, 5)
                
                // MARK: - Todo 미리보기 바디
                Spacer()
                    .frame(height: RealmManager.shared.getSortedTodoList(type: .preview).count == 0 ? 140 : 0)
                
                ForEach(RealmManager.shared.getSortedTodoList(type: .preview).prefix(3)) { list in
                    HStack {
                        Button {
                            RealmManager.shared.toggleCompleted(list)
                        } label: {    // 완료여부에 따라 이미지 변경
                            Image(systemName: list.completed ? "checkmark.circle.fill" : "circle")
                        }
                        .buttonStyle(PlainButtonStyle())
                        .foregroundStyle(list.completed ? Color.green : Color.base)
                        Spacer()
                        Text("\(list.title)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(10)
                            .font(.pretendardSemiBold_15)
                            .foregroundStyle(list.completed ? Color.gray : Color.base)
                    }
                    .padding(.leading, 20)
                    .offset(y: 25)
                }
                .scrollContentBackground(.hidden)
                .frame(width: 350)
                .offset(y: -20)
                Spacer()
                    .frame(height: RealmManager.shared.getSortedTodoList(type: .preview).count == 1 ? 110 : (RealmManager.shared.getSortedTodoList(type: .preview).count == 2 ? 60 : 10))
            }
        }
    }
}

#Preview {
    TodoPreView()
}
