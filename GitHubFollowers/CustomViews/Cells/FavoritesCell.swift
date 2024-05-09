//
//  FavoritesCell.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/8/24.
//

import SwiftUI

struct FavoritesCell: View {
    let follower: Follower
    @State private var avatarImage: UIImage?
    
    var body: some View {
        HStack{
            
            if let avatarImage {
                GHFAvatarImageView(placeholderImage: Image(uiImage: avatarImage))
                    .padding(.top, 8)
                    .frame(width: 60, height: 60)
            } else {
                GHFAvatarImageView()
                    .padding(.top, 8)
                    .frame(width: 60, height: 60)
            }
            
            
            GHFTitleLabelView(titleText: follower.login, textAlignment: .leading, fontSize: 26)
                .padding(.bottom, 5)
        }
        .onAppear {
            Task {
                let cacheKey = NSString(string: follower.avatarUrl)
                
                if let image = NetworkManager.cache.object(forKey: cacheKey) {
                    avatarImage = image
                    return
                }
                
                avatarImage = try await NetworkManager.shared.downloadImage(from: follower.avatarUrl)
                NetworkManager.cache.setObject(avatarImage ?? UIImage(resource: .avatarPlaceholder), forKey: cacheKey)
            }
        }
    }
}

#Preview {
    FavoritesCell(follower: .Example)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 2)
        )
}
