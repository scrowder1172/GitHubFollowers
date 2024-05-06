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
    @State private var isLoadingFollowers: Bool = false
    @State private var searchText: String = ""
    @State private var followerSet: Set<String> = []
    @State private var lastIndexRequested: Int = 0
    @State private var isShowingUserDetailView: Bool = false
    @State private var selectedFollower: Follower?
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return followers
        } else {
            return followers.filter { $0.login.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                if followers.isEmpty {
                    GHFEmptyStateView(message: "This user doesn't have any followers 😞.")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(filteredFollowers) { follower in
                                FollowerCell(follower: follower, followerSet: $followerSet)
                                    .onTapGesture {
                                        selectedFollower = follower
                                    }
                            }
                        }
                    }
                    .onChange(of: followerSet) { oldValue, newValue in
                        if hasMoreFollowers, followerSet.count == followers.count {
                            getFollowers()
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search for specific followers")
                    Text("Follower count: \(followers.count)")
                }
            }
            .opacity(isLoadingFollowers ? 0.5 : 1.0)
            .disabled(isLoadingFollowers)
            .sheet(item: $selectedFollower) { _ in
                if let selectedFollower {
                    UserDetailView(username: selectedFollower.login)
                }
            }
            
            if isLoadingFollowers {
                ProgressView()
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
            isLoadingFollowers = true
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
            isLoadingFollowers = false
        }
    }
}

#Preview {
    FollowersView(gitHubUser: "Sallen0400")
}
