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
    @State private var isLoadingFollowers: Bool = false
    
    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]
    
    var body: some View {
        ZStack{
            VStack{
                if followers.isEmpty {
                    GHFEmptyStateView(message: "This user doesn't have any followers 😞.")
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
            .opacity(isLoadingFollowers ? 0.5 : 1.0)
            .disabled(isLoadingFollowers)
            
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
    FollowersView(gitHubUser: "Scrowder1172")
}
