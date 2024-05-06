//
//  UserDetailView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/6/24.
//

import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let follower: Follower
    @State private var avatarImage: UIImage?
    
    var body: some View {
        NavigationStack {
            HStack {
                if let avatarImage {
                    GHFAvatarImageView(placeholderImage: Image(uiImage: avatarImage))
                        .padding(.top, 8)
                } else {
                    GHFAvatarImageView()
                        .padding(.top, 8)
                }
                
                VStack {
                    GHFTitleLabelView(titleText: follower.login, textAlignment: .center, fontSize: 16)
                        .padding(.bottom, 5)
                    GHFBodyLabelView(bodyText: follower.avatarUrl, textAlignment: .leading)
                }
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
            .navigationTitle(follower.login)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    UserDetailView(follower: .Example)
}
