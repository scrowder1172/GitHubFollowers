//
//  ContentView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/1/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
        .tint(.green)
    }
}

#Preview {
    MainView()
}
