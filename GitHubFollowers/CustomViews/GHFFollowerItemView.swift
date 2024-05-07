//
//  GHFFollowerItemView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFFollowerItemView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                GHFItemInfoView(itemCount: user.following, itemInfoType: .following)
                Spacer()
                GHFItemInfoView(itemCount: user.followers, itemInfoType: .followers)
            }
            GHFButton(backgroundColor: .green, title: "Get Followers") {
                print("Getting follower data...")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(Color.secondarySystemBackground)
        .clipShape(.rect(cornerRadius: 18))
    }
}

#Preview {
    GHFFollowerItemView(user: .ExampleUser)
}
