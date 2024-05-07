//
//  GHFUserInfoHeaderView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFUserInfoHeaderView: View {
    
    let user: User
    
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
                    GHFTitleLabelView(titleText: user.login, textAlignment: .leading, fontSize: 34)
                    GHFSecondaryTitleLabelView(bodyText: user.name ?? "", textAlignment: .leading)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.large)
                        GHFSecondaryTitleLabelView(bodyText: user.location ?? "No location", textAlignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 10)
            
            GHFBodyLabelView(bodyText: user.bio ?? "No bio given", textAlignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            Task {
                do {
                    let cacheKey = NSString(string: user.avatarUrl)
                    print(user.avatarUrl)
                    
                    if let image = NetworkManager.cache.object(forKey: cacheKey) {
                        avatarImage = image
                        return
                    }
                    
                    avatarImage = try await NetworkManager.shared.downloadImage(from: user.avatarUrl)
                    NetworkManager.cache.setObject(avatarImage ?? UIImage(resource: .avatarPlaceholder), forKey: cacheKey)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadUserDetails() {
        
    }
}

#Preview {
    GHFUserInfoHeaderView(user: .ExampleUser)
}
