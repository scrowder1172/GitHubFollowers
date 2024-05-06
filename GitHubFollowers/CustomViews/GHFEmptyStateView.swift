//
//  EmptyStateView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/6/24.
//

import SwiftUI

struct GHFEmptyStateView: View {
    
    let message: String
    
    var body: some View {
        VStack {
            GHFTitleLabelView(titleText: message, textAlignment: .center, fontSize: 28)
                .opacity(0.6)
            
            Image(.emptyStateLogo)
                .resizable()
                .scaledToFit()
                .scaleEffect(1.3)
                .offset(x: 140, y: 200)
        }
    }
}

#Preview {
    GHFEmptyStateView(message: "This user doesn't have any followers. Go follow them 😄")
}
