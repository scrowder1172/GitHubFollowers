//
//  FollowersView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FollowersView: View {
    
    let gitHubUser: String
    
    var body: some View {
        VStack{
            ContentUnavailableView(label: {
                Label("Followers", systemImage: "person.3.fill")
            }, description: {
                Text("This will be a list of followers for \(gitHubUser)")
            })
        }
        .navigationTitle(gitHubUser)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    FollowersView(gitHubUser: "Hello")
}
