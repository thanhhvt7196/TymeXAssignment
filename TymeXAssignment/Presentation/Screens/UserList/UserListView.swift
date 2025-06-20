//
//  UserListView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI
import SwiftData

struct UserListView: View {
    @Environment(Router.self) private var router: Router
    @State private var userListObservable: UserListObservable
    
    init(usecase: UserListUsecase) {
        _userListObservable = State(wrappedValue: UserListObservable(usecase: usecase))
    }
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.path) {
            contentView
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
                .navigationDestination(for: RouterPath.self) { path in
                    switch path {
                    case .userDetail(let user):
                        UserFlowBuilder.buildUserDetail(username: user.login ?? "")
                    }
                }
                .showErrorAlert(
                    isPresented: Binding<Bool>(
                        get: {
                            userListObservable.errorMessage != nil
                        },
                        set: { newValue in
                            if !newValue {
                                userListObservable.errorMessage = nil
                            }
                        }
                    ),
                    message: userListObservable.errorMessage ?? ""
                )
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if userListObservable.isLoading && userListObservable.userList.isEmpty {
            skeletonView
        } else {
            listView
                .accessibilityIdentifier("userList")
        }
    }
    
    @ViewBuilder
    private var skeletonView: some View {
        VStack(spacing: 16) {
            SkeletonView {
                RoundedRectangle(cornerRadius: 12)
            }
            .frame(height: 160)

            SkeletonView {
                RoundedRectangle(cornerRadius: 12)
            }
            .frame(height: 160)

            SkeletonView {
                RoundedRectangle(cornerRadius: 12)
            }
            .frame(height: 160)
            
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    private var listView: some View {
        List {
            ForEach(userListObservable.userList) { user in
                PlainListCell {
                    UserListItemView(user: user)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    router.path.append(RouterPath.userDetail(user))
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
    UserFlowBuilder.buildUserList()
}
