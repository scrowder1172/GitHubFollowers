//
//  FollowersView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FollowersView: View {
    
    let gitHubUser: String
    
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = "An error has occurred. Please try again."
    @State private var followers: [Follower]?
    
    var body: some View {
        VStack{
            if let followers {
                List(followers) { follower in
                    Text(follower.login)
                }
                Text("Follower count: \(followers.count)")
            } else {
                ContentUnavailableView(label: {
                    Label("Followers", systemImage: "person.3.fill")
                }, description: {
                    Text("This will be a list of followers for \(gitHubUser)")
                })
            }
        }
        .onAppear {
            Task {
                do {
                    followers = try await NetworkManager.shared.getFollowers(for: gitHubUser, page: 1)
                } catch {
                    errorMessage = error.localizedDescription
                    isShowingAlert = true
                }
            }
        }
        .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
        .navigationTitle(gitHubUser)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    FollowersView(gitHubUser: "Hello")
}
