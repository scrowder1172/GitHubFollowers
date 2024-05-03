//
//  GHFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import SwiftUI

struct GHFAvatarImageView: View {
    
    let placeholderImage: Image = Image(.avatarPlaceholder)
    
    var body: some View {
        placeholderImage
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    GHFAvatarImageView()
}
