//
//  UserListView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var router: Router
    
    @State private var userListObservable = UserListObservable(service: ServiceContainer.get())
    
    var body: some View {
        NavigationStack(path: $router.path) {
            listView
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(L10n.userListScreenTitle)
                            .foregroundStyle(.baseText)
                            .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 18))
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.white, for: .navigationBar)
        }
    }
    
    @ViewBuilder
    private var listView: some View {
        List {
            ForEach(Array(userListObservable.userList.enumerated()), id: \.element) { index, user in
                PlainListCell {
                    UserListItemView(user: user)
                }
                .onAppear {
                    if index == userListObservable.userList.count - 1 {
                        Task {
                            await userListObservable.loadMore()
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
        .listRowInsets(EdgeInsets())
        .scrollContentBackground(.hidden)
        .background(.baseWhite)
        .refreshable {
            await userListObservable.loadFirstPage(needLoading: false)
        }
    }
}

#Preview {
    UserListView()
}
