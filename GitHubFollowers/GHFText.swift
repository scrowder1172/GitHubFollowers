//
//  GHFText.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFText: View {
    
    let backgroundColor: Color
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.white)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

#Preview {
    GHFText(backgroundColor: .green, title: "Get Followers")
}
