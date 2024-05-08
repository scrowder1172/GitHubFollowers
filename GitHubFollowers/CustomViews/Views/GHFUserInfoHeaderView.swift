//
//  GHFUserInfoHeaderView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFUserInfoHeaderView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    
//    let user: User
    
    @State private var avatarImage: UIImage?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let avatarImage {
                    Image(uiImage: avatarImage)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .scaledToFit()
                } else {
                    Image(.avatarPlaceholder)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .scaledToFit()
                }
                VStack(alignment: .leading) {
                    GHFTitleLabelView(titleText: gitHubManager.gitHubUser.login, textAlignment: .leading, fontSize: 34)
                    GHFSecondaryTitleLabelView(bodyText: gitHubManager.gitHubUser.name ?? "", textAlignment: .leading)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                        GHFSecondaryTitleLabelView(bodyText: gitHubManager.gitHubUser.location ?? "No location", textAlignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            
            GHFBodyLabelView(bodyText: gitHubManager.gitHubUser.bio ?? "No bio given", textAlignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            Task {
                do {
                    let cacheKey = NSString(string: gitHubManager.gitHubUser.avatarUrl)
                    print(gitHubManager.gitHubUser.avatarUrl)
                    
                    if let image = NetworkManager.cache.object(forKey: cacheKey) {
                        avatarImage = image
                        return
                    }
                    
                    avatarImage = try await NetworkManager.shared.downloadImage(from: gitHubManager.gitHubUser.avatarUrl)
                    NetworkManager.cache.setObject(avatarImage ?? UIImage(resource: .avatarPlaceholder), forKey: cacheKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    GHFUserInfoHeaderView()
        .environment(GitHubManager())
}
