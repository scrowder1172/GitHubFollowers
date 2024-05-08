//
//  GHFFollowerItemView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFFollowerItemView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    @Environment(\.dismiss) private var dismiss
    
//    let user: User
    
    var body: some View {
        VStack {
            HStack {
                GHFItemInfoView(itemCount: gitHubManager.gitHubUser.following, itemInfoType: .following)
                Spacer()
                GHFItemInfoView(itemCount: gitHubManager.gitHubUser.followers, itemInfoType: .followers)
            }
            GHFButton(backgroundColor: .green, title: "Get Followers") {
                print("Getting follower data...")
                gitHubManager.username = gitHubManager.gitHubUser.login
                gitHubManager.refreshFollowerList = true
                dismiss()
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(Color.secondarySystemBackground)
        .clipShape(.rect(cornerRadius: 18))
    }
}

#Preview {
    GHFFollowerItemView()
        .environment(GitHubManager())
}
