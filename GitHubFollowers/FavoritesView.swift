//
//  FavoritesView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(GitHubManager.self) private var gitHubManager
    
    @State private var favorites: [Follower] = []
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = ""
    
    @ViewBuilder
    private func captureGitHubUsername(favorite: Follower) -> some View {
        EmptyView()
            .onAppear {
                gitHubManager.username = favorite.login
                print("capturing favorite: \(favorite)")
            }
    }
    
    var body: some View {
        NavigationStack{
            Group{
                if favorites.isEmpty {
                    GHFEmptyStateView(message: "You haven't added any favorites yet ⭐️")
                } else {
                    List {
                        ForEach(favorites) {favorite in
                            NavigationLink(value: favorite) {
                                FavoritesCell(follower: favorite)
                            }
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                }
            }
            .navigationDestination(for: Follower.self) { favorite in
                FollowersView()
                    .onAppear {
                        gitHubManager.username = favorite.login
                    }
            }
            .navigationTitle("Favorites")
        }
        .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
        .onAppear {
            loadFavorites()
        }
    }
    
    func loadFavorites() {
        do {
            favorites = try PersistenceManager.shared.loadFavorites()
            print("Loaded favorites: \(favorites)")
        } catch {
            errorMessage = error.localizedDescription
            isShowingAlert = true
        }
    }
    
    func deleteFavorite(at offsets: IndexSet) {
        do {
            favorites.remove(atOffsets: offsets)
            try PersistenceManager.shared.removeFavorite(at: offsets)
        } catch {
            errorMessage = error.localizedDescription
            isShowingAlert = true
        }
    }
    
    
}

#Preview {
    FavoritesView()
        .environment(GitHubManager())
}
