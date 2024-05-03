//
//  SearchView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    @State private var isShowingAlert: Bool = false
    @State private var navigateToFollowers: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(.ghLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50 )
                    .padding(.top, 80)
                
                GHFTextField(inputText: $searchText)
                    .frame(height: 50)
                    .padding(.horizontal, 50)
                
                Spacer()
                
                GHFButton(backgroundColor: .green, title: "Get Followers") {
                    if searchText.isEmpty {
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
                FollowersView(gitHubUser: searchText)
            }
            .background(Color.systemBackground)
            .toolbar(.hidden) // hides navbar
        }
    }
}

#Preview {
    SearchView()
}

#Preview("TabView") {
    GHFTabView()
}

