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
    @State private var followers: [Follower] = []
    @State private var hasMoreFollowers: Bool = true
    @State private var pageNumber: Int = 0
    @State private var followerCount: Int = 0
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        VStack{
            if followers.isEmpty {
                ContentUnavailableView(label: {
                    Label("Followers", systemImage: "person.3.fill")
                }, description: {
                    Text("This will be a list of followers for \(gitHubUser)")
                })
            } else {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(followers) { follower in
                            FollowerCell(follower: follower, followerCount: $followerCount)
                        }
                    }
                }
                .onChange(of: followerCount) { oldValue, newValue in
//                    print("Follower Count: \(newValue)")
                    if hasMoreFollowers, newValue == followers.count {
                        getFollowers()
                    }
                }
                Text("Follower count: \(followers.count)")
            }
        }
        .onAppear {
            getFollowers()
        }
        .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
        .navigationTitle(gitHubUser)
        .navigationBarTitleDisplayMode(.large)
        .padding(.horizontal, 5)
    }
    
    func getFollowers() {
        Task {
            do {
                pageNumber += 1
                let newFollowers = try await NetworkManager.shared.getFollowers(for: gitHubUser, page: pageNumber)
                followers.append(contentsOf: newFollowers)
                if followers.count < 100 {
                    hasMoreFollowers = false
                }
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
        }
    }
}

#Preview {
    FollowersView(gitHubUser: "SAllen0400")
}
