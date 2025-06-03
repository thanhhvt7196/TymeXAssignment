import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject private var router: Router
    @State private var userDetailObservable: UserDetailObservable
    
    init(username: String) {
        _userDetailObservable = State(wrappedValue: UserDetailObservable(service: ServiceContainer.get(), username: username))
    }
    
    var body: some View {
        contentView
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.baseText)
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            if !router.path.isEmpty {
                                router.path.removeLast()
                            }
                        }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(L10n.userDetailScreenTitle)
                        .foregroundStyle(.baseText)
                        .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 18))
                }
            }
            .showErrorAlert(
                isPresented: Binding<Bool>(
                    get: {
                        userDetailObservable.errorMessage != nil
                    },
                    set: { newValue in
                        if !newValue {
                            userDetailObservable.errorMessage = nil
                        }
                    }
                ),
                message: userDetailObservable.errorMessage ?? ""
            )
    }
    
    @ViewBuilder
    private var contentView: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 12)
                
                detailCardView
                
                Spacer()
                    .frame(height: 24)
                
                followerSection
                    .frame(maxWidth: .infinity)

                Spacer()
                    .frame(height: 24)
                
                if let url = userDetailObservable.userDetail?.htmlUrl {
                    blogSection(url: url)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    private var detailCardView: some View {
        if userDetailObservable.isLoading {
            SkeletonView {
                RoundedRectangle(cornerRadius: 12)
            }
            .frame(height: 160)
            .padding()
        } else {
            UserCardView(avatarUrl: userDetailObservable.userDetail?.avatarUrl, name: userDetailObservable.userDetail?.name ?? "", location: userDetailObservable.userDetail?.location)
        }
    }
    
    @ViewBuilder
    private var followerSection: some View {
        if userDetailObservable.isLoading {
            HStack(spacing: 50) {
                SkeletonView {
                    Circle()
                }
                .frame(width: 48, height: 48)
                
                SkeletonView {
                    Circle()
                }
                .frame(width: 48, height: 48)
            }
        } else {
            HStack(spacing: 50) {
                UserFollowView(icon: Asset.Assets.followers, title: L10n.followerTitle, value: userDetailObservable.userDetail?.followers?.string ?? "")
                
                UserFollowView(icon: Asset.Assets.following, title: L10n.followingTitle, value: userDetailObservable.userDetail?.following?.string ?? "")
            }
        }
    }
    
    @ViewBuilder
    private func blogSection(url: String) -> some View {
        if !userDetailObservable.isLoading {
            VStack(alignment: .leading, spacing: 12) {
                Text(L10n.blogTitle)
                    .foregroundStyle(.baseText)
                    .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 24))
                    .padding(.horizontal)
                
                Text(url)
                    .foregroundStyle(.link)
                    .font(FontFamily.TTNormsPro.medium.swiftUIFont(size: 16))
                    .padding(.horizontal)
                    .onTapGesture {
                        guard let url = URL(string: url) else {
                            return
                        }
                        UIApplication.shared.open(url)
                    }
            }
        }
    }
}

#Preview {
    UserDetailView(username: "wycats")
}
