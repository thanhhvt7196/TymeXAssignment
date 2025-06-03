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
            ForEach(userListObservable.userList) { user in
                PlainListCell {
                    UserListItemView(user: user)
                }
                .onAppear {
                    if user == userListObservable.userList.last {
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
