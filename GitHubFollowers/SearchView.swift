//
//  SearchView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    
//    @State private var searchText: String = ""
    
    @State private var isShowingAlert: Bool = false
    @State private var navigateToFollowers: Bool = false
    
    var body: some View {
        @Bindable var gitHubManager = gitHubManager
        NavigationStack{
            VStack {
                Image(.ghLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50 )
                    .padding(.top, 80)
                
                GHFTextField(inputText: $gitHubManager.username)
                    .frame(height: 50)
                    .padding(.horizontal, 50)
                
                Spacer()
                
                GHFButton(backgroundColor: .green, title: "Get Followers") {
                    if gitHubManager.username.isEmpty {
                        isShowingAlert = true
                    } else {
                        navigateToFollowers = true
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            }
            .ghfAlert(isShowingAlert: $isShowingAlert, title: "Empty Username", message: "Please enter a username. We need to know who to look for 😄", buttonText: "OK")
            .navigationDestination(isPresented: $navigateToFollowers) {
                FollowersView()
            }
            .background(Color.systemBackground)
            .toolbar(.hidden) // hides navbar
        }
    }
}

#Preview {
    SearchView()
        .environment(GitHubManager())
}

#Preview("TabView") {
    MainView()
}

