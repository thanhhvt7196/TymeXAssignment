//
//  UserListView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI

struct UserListView: View {
    @EnvironmentObject private var router: Router
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
            PlainListCell {
                Text("UserListView")
                    .background(.yellow)
            }
        }
        .listStyle(.plain)
        .listRowInsets(EdgeInsets())
        .scrollContentBackground(.hidden)
        .background(.baseWhite)
    }
}

#Preview {
    UserListView()
}
