//
//  FavoritesView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label("Favorites", systemImage: "star.fill")
        }, description: {
            Text("This view will be replaced by the Favorites View")
        })
    }
}

#Preview {
    FavoritesView()
}
