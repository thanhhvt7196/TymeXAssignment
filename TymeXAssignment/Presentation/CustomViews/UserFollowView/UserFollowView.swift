//
//  UserFollowView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI

struct UserFollowView: View {
    let icon: ImageAsset
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Group {
                icon.swiftUIImage
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.baseText)
                    .frame(width: 36, height: 36)
            }
            .frame(width: 48, height: 48, alignment: .center)
            .background(Circle().fill(.baseShadow))
            
            Text(value)
                .foregroundStyle(.baseText)
                .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 14))
            
            Text(title)
                .font(FontFamily.TTNormsPro.regular.swiftUIFont(size: 14))
                .foregroundStyle(.baseText)
        }
    }
}

#Preview {
    UserFollowView(icon: Asset.Assets.followers, title: L10n.followerTitle, value: "100+")
}
