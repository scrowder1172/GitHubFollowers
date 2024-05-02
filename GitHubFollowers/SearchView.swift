//
//  SearchView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Image(.ghLogo)
                .resizable()
                .scaledToFit()
        }, description: {
            Text("This view will be replaced by the Search View")
        })
    }
}

#Preview {
    SearchView()
}
