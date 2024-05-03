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
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
        }
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    GHFButton(backgroundColor: .green, title: "Get Followers") {
        // do work
    }
}

#Preview("TabView") {
    MainView()
}

