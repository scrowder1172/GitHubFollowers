//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import SwiftUI

struct FollowerCell: View {
    
    let follower: Follower
    
    var body: some View {
        VStack{
            GHFAvatarImageView()
                .padding(.top, 8)
            
            GHFTitleLabelView(titleText: follower.login, textAlignment: .center, fontSize: 16)
                .padding(.bottom, 5)
        }
    }
}

#Preview {
    FollowerCell(follower: .Example)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.secondary, lineWidth: 2)
        )
}
