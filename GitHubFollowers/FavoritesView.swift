//
//  FavoritesView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        GHFEmptyStateView(message: "You haven't added any favorites yet ⭐️")
    }
}

#Preview {
    FavoritesView()
}
