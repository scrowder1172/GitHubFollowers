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
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .padding(5)
            } else {
                GHFAvatarImageView()
                    .padding(.top, 8)
            }
            
            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
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
