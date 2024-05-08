//
//  GHFItemView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFRepoItemView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    
//    let user: User
    @State private var isShowingSafari: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                GHFItemInfoView(itemCount: gitHubManager.gitHubUser.publicRepos, itemInfoType: .repos)
                Spacer()
                GHFItemInfoView(itemCount: gitHubManager.gitHubUser.publicGists, itemInfoType: .gists)
            }
            GHFButton(backgroundColor: .purple, title: "GitHub Profile") {
                isShowingSafari = true
            }
        }
        .sheet(isPresented: $isShowingSafari) {
            SafariView(url: URL(string: gitHubManager.gitHubUser.htmlUrl)!)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(Color.secondarySystemBackground)
        .clipShape(.rect(cornerRadius: 18))
    }
}

#Preview {
    GHFRepoItemView()
        .environment(GitHubManager())
}
