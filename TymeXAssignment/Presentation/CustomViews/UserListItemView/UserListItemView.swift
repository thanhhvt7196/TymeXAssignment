//
//  Untitled.swift
//  TymeXAssignment
//
//  Created by thanh tien on 2/6/25.
//

import SwiftUI
import Kingfisher

struct UserListItemView: View {
    let user: GitHubUser
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(URL(string: user.avatarUrl ?? ""))
                .resizable()
                .fade(duration: 0.2)
                .placeholder({
                    Asset.Assets.avatarDefault.swiftUIImage
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
                })
                .frame(width: 120, height: 120)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.login ?? "")
                    .foregroundStyle(.baseText)
                    .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 30))
                
                Divider()
                
                if let htmlUrl = user.htmlUrl, let url = URL(string: htmlUrl) {
                    Text(htmlUrl)
                        .foregroundStyle(.link)
                        .font(FontFamily.TTNormsPro.medium.swiftUIFont(size: 16))
                        .underline()
                        .onTapGesture {
                            UIApplication.shared.open(url)
                        }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        .shadow(color: .baseShadow, radius: 24, x: 0, y: 4)
        .padding()
    }
}

#Preview {
    UserListItemView(
        user: .init(
            login: "David",
            id: 1,
            nodeId: nil,
            avatarUrl: "https://google.com",
            gravatarId: nil, url: nil,
            htmlUrl: "https://google.com",
            followersUrl: nil,
            followingUrl: nil,
            gistsUrl: nil,
            starredUrl: nil,
            subscriptionsUrl: nil,
            organizationsUrl: nil,
            reposUrl: nil,
            eventsUrl: nil,
            receivedEventsUrl: nil,
            type: nil,
            userViewType: nil,
            siteAdmin: nil
        )
    )
}
