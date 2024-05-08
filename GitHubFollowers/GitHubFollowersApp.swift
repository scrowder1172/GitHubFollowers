//
//  GitHubFollowersApp.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/1/24.
//

import SwiftUI

@main
struct GitHubFollowersApp: App {
    
    @State private var gitHubManager: GitHubManager = GitHubManager()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(gitHubManager)
        }
    }
}
