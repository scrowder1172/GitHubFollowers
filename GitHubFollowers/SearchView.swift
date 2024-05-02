//
//  SearchView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/2/24.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack {
                Image(.ghLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 50 )
                    .padding(.top, 80)
                
                GHFTextField(inputText: $searchText)
                    .frame(height: 50)
                    .padding(.horizontal, 50)
                
                Spacer()
                
                GHFButton(backgroundColor: .green, title: "Get Followers") {
                    print("Button clicked")
                }
                .frame(height: 50)
                .padding(.horizontal, 50)
                .padding(.bottom, 50)
            }
            .background(Color.systemBackground)
            .toolbar(.hidden) // hides navbar
        }
    }
}

#Preview {
    SearchView()
}

#Preview("TabView") {
    GHFTabView()
}

