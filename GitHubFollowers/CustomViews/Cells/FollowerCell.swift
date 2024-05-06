//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import SwiftUI

struct FollowerCell: View {
    
    let follower: Follower
    @Binding var followerSet: Set<String>
    @State private var avatarImage: UIImage?
    
    var body: some View {
        VStack{
            
            if let avatarImage {
                GHFAvatarImageView(placeholderImage: Image(uiImage: avatarImage))
                    .padding(.top, 8)
            } else {
                GHFAvatarImageView()
                    .padding(.top, 8)
            }
            
            
            GHFTitleLabelView(titleText: follower.login, textAlignment: .center, fontSize: 16)
                .padding(.bottom, 5)
        }
        .onAppear {
            Task {
                followerSet.insert(follower.id)
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
    FollowerCell(follower: .Example, followerSet: .constant([]))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 2)
        )
}
