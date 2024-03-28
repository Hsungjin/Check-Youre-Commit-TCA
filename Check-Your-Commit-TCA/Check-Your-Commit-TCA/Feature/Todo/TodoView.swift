//
//  TodoView.swift
//  Check-Your-Commit-TCA
//
//  Created by 황성진 on 3/25/24.
//

import ComposableArchitecture
import SwiftUI
import RealmSwift

struct TodoView: View {
    @Bindable var store: StoreOf<TodoFeature>
    @FocusState var focused: Bool
    
    var body: some View {
        ZStack {
            Color.bgColor // 배경색 변경
                .ignoresSafeArea(.all)
                // MARK: - 헤더
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("할 일 목록")
                            .font(.pretendardBold_25)
                            .padding(.leading, 15)
                            .padding(.top, 10)
                        
                        Spacer()
                    }
                    
                    // MARK: - 리스트
                    List {
                        ForEach(store.sortedTodoModel) { todo in
                            HStack {
                                Button {
                                    RealmManager.shared.toggleCompleted(todo)
                                    store.send(.getTodoList)
                                } label: {    // 완료여부에 따라 이미지 변경
                                    Image(systemName: todo.completed ? "checkmark.circle.fill" : "circle")
                                }
                                .foregroundStyle(todo.completed ? Color.green : Color.base) // 완료여부에 따라 이미지 색 변경
                                
                                Text(todo.title)
                                    .foregroundStyle(todo.completed ? Color.gray : Color.base) // 완료여부에 따라 폰트 색 변경
                                    .font(.pretendardSemiBold_15)
                            }
                            .listRowBackground(Color.bgColor)
                        }
                        .onDelete { indexSet in // onDelete 클로저
                            let todosToDelete = indexSet.map { store.sortedTodoModel[$0] }
                            for todo in todosToDelete {
                                RealmManager.shared.deleteTodoList(todo)
                            }
                            store.send(.getTodoList) // 삭제 후 리스트 갱신
                        }
                        
                        if store.isTextFieldShowing {   // textField 생성 조건문
                            HStack{
                                Image(systemName: "circle")
                                
                                TextField("일정을 입력해주세요", text: $store.textField.sending(\.textFieldChange), onCommit: {
                                    if !store.textField.isEmpty {
                                        RealmManager.shared.writeTodoList(store.textField)
                                        store.send(.getTodoList)
                                    }
                                    store.send(.testFieldShowing(false))
                                })
                                .font(.pretendardSemiBold_15)
                                .focused($focused)
                            }
                            .scrollContentBackground(.hidden)
                            .listRowBackground(Color.bgColor)
                            .background(Color.bgColor)
                            .onAppear {  // 텍스트 필드 생성시 키보드 자동 등장
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.focused = true
                                }
                            }
                        }
                    }
                    .scrollDisabled(true)
                    .padding(.top, -20)
                    .padding(.leading, -15)
                    // MARK: - "새로운 일정" 버튼
                    Button {
                        store.send(.testFieldShowing(true))
                        store.send(.textFieldChange(""))
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("새로운 일정")
                        }
                        .padding([.leading, .bottom], 20)
                    }
                    .foregroundColor(Color.baseColor)
                }
                .scrollContentBackground(.hidden)
        }
        .navigationTitle("오늘 뭐해?")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButtonView())
        .onAppear {
            store.send(.getTodoList)
        }
    }
}
