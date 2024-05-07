//
//  GHFItemView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFRepoItemView: View {
    
    let user: User
    
    var body: some View {
        VStack {
            HStack {
                GHFItemInfoView(itemCount: user.publicRepos, itemInfoType: .repos)
                Spacer()
                GHFItemInfoView(itemCount: user.publicGists, itemInfoType: .gists)
            }
            GHFButton(backgroundColor: .purple, title: "GitHub Profile") {
                print("Getting profile data...")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(Color.secondarySystemBackground)
        .clipShape(.rect(cornerRadius: 18))
    }
}

#Preview {
    GHFRepoItemView(user: .ExampleUser)
}
