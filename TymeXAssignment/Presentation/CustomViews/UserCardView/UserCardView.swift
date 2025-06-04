//
//  UserCardView.swift
//  TymeXAssignment
//
//  Created by thanh tien on 3/6/25.
//

import SwiftUI
import Kingfisher

struct UserCardView: View {
    let avatarUrl: String?
    let name: String
    let location: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(URL(string: avatarUrl ?? ""))
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
                Text(name)
                    .foregroundStyle(.baseText)
                    .font(FontFamily.TTNormsPro.bold.swiftUIFont(size: 30))
                
                if let location = location {
                    Divider()
                    
                    Spacer()
                        .frame(height: 20)

                    HStack(spacing: 8) {
                        Asset.Assets.place.swiftUIImage
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.baseIcon)
                            .frame(width: 20, height: 20)
                        
                        Text(location)
                            .foregroundStyle(.baseText)
                            .font(FontFamily.TTNormsPro.medium.swiftUIFont(size: 16))
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
        )
        .shadow(color: .baseShadow, radius: 24, x: 0, y: 4)
        .padding()
    }
}

#Preview {
    UserCardView(avatarUrl: "https://avatars.githubusercontent.com/u/28?v=4", name: "roland", location: "Philipines")
}
