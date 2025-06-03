import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject private var router: Router
    @State private var userDetailObservable: UserDetailObservable
    
    init(username: String) {
        _userDetailObservable = State(wrappedValue: UserDetailObservable(service: ServiceContainer.get(), username: username))
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                    .frame(height: 12)
                
                detailCardView
                
                Spacer()
                    .frame(height: 24)
                
                followerSection
                
                Spacer()
                    .frame(height: 24)
                
                if let url = userDetailObservable.userDetail?.htmlUrl {
                    blogSection(url: url)
                }
            }
            .frame(maxWidth: .infinity)
        }
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
    }
    
    @ViewBuilder
    private var detailCardView: some View {
        UserCardView(avatarUrl: userDetailObservable.userDetail?.avatarUrl, name: userDetailObservable.userDetail?.name ?? "", location: userDetailObservable.userDetail?.location)
    }
    
    @ViewBuilder
    private var followerSection: some View {
        HStack(spacing: 50) {
            UserFollowView(icon: Asset.Assets.followers, title: L10n.followerTitle, value: userDetailObservable.userDetail?.followers?.string ?? "")
            
            UserFollowView(icon: Asset.Assets.following, title: L10n.followingTitle, value: userDetailObservable.userDetail?.following?.string ?? "")
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func blogSection(url: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(L10n.blogTitle)
                .foregroundStyle(.baseText)
                .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 24))
                .padding(.horizontal)
            
            Spacer()
                .frame(height: 12)
            
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

#Preview {
    UserDetailView(username: "wycats")
}
