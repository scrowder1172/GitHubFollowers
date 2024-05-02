//
//  GHFButton.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct GHFButton: View {
    
    let backgroundColor: Color
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

#Preview {
    GHFButton(backgroundColor: .green, title: "Get Followers") {
        // do work
    }
}

#Preview("TabView") {
    GHFTabView()
}

