//
//  FollowersView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FollowersView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    
//    let gitHubUser: String
    
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = "An error has occurred. Please try again."
//    @State private var followers: [Follower] = []
    @State private var hasMoreFollowers: Bool = true
    @State private var pageNumber: Int = 0
    @State private var isLoadingFollowers: Bool = false
    @State private var searchText: String = ""
    @State private var followerSet: Set<String> = []
    @State private var lastIndexRequested: Int = 0
    @State private var isShowingUserDetailView: Bool = false
    @State private var selectedFollower: Follower? = nil
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var filteredFollowers: [Follower] {
        if searchText.isEmpty {
            return gitHubManager.followers
        } else {
            return gitHubManager.followers.filter { $0.login.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                if gitHubManager.followers.isEmpty {
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
                        if hasMoreFollowers{
                            if followerSet.count == gitHubManager.followers.count {
                                getFollowers()
                            }
                        }
                    }
                    .searchable(text: $searchText, prompt: "Search for specific followers")
                    HStack{
                        Text("Total Followers: \(gitHubManager.gitHubUser.followers)")
                        Spacer()
                        Text("Displayed: \(gitHubManager.followers.count)")
                    }
                    .font(.caption)
                    .padding(5)
                }
            }
            .opacity(isLoadingFollowers ? 0.5 : 1.0)
            .disabled(isLoadingFollowers)
            .sheet(item: $selectedFollower) { follower in
                UserDetailView(username: follower.login)
            }
            .onChange(of: gitHubManager.refreshFollowerList) { oldValue, newValue in
                if gitHubManager.refreshFollowerList {
                    pageNumber = 0
                    getFollowers()
                    gitHubManager.refreshFollowerList = false
                }
            }
            
            if isLoadingFollowers {
                ProgressView()
            }
            
        }
        .navigationTitle(gitHubManager.username)
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            getUserDetails()
            getFollowers()
        }
        .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
        .padding(.horizontal, 5)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add", systemImage: "plus") {
                    saveFavorite()
                }
            }
        }
    }
    
    func saveFavorite() {
        Task {
            do {
                let user = try await NetworkManager.shared.getUserDetails(for: gitHubManager.username)
                let favorite: Follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
                print("Saving new favorite: \(favorite)")
                try PersistenceManager.shared.saveFavorite(newFavorite: favorite)
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
        }
    }
    
    func getUserDetails() {
        Task {
            gitHubManager.gitHubUser = try await NetworkManager.shared.getUserDetails(for: gitHubManager.username)
        }
    }
    
    func getFollowers() {
        Task {
            isLoadingFollowers = true
            do {
                if pageNumber == 0 {
                    resetFollowers()
                }
                
                pageNumber += 1
                let newFollowers = try await NetworkManager.shared.getFollowers(for: gitHubManager.username, page: pageNumber)
                gitHubManager.followers.append(contentsOf: newFollowers)
                if newFollowers.count < 100 {
                    hasMoreFollowers = false
                }
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
            isLoadingFollowers = false
        }
    }
    
    func resetFollowers() {
        hasMoreFollowers = true
        gitHubManager.followers = []
        followerSet = []
    }
}

#Preview {
    FollowersView()
        .environment(GitHubManager())
}
