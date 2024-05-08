//
//  ItemInfoView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/7/24.
//

import SwiftUI

struct GHFItemInfoView: View {
    
    let itemCount: Int
    let itemInfoType: ItemInfoType
    
    var titleText: String {
        switch itemInfoType {
        case .repos:
            "Public Repos"
        case .gists:
            "Public Gists"
        case .followers:
            "Followers"
        case .following:
            "Following"
        }
    }
    
    var image: Image {
        switch itemInfoType {
        case .repos:
            Image(systemName: "folder")
        case .gists:
            Image(systemName: "text.alignleft")
        case .followers:
            Image(systemName: "heart")
        case .following:
            Image(systemName: "person.2")
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(titleText)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.label)
            }
            
            Text("\(itemCount)")
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.label)
        }
    }
}

#Preview {
    GHFItemInfoView(itemCount: Int.random(in: 0...100), itemInfoType: .followers)
}
