//
//  UserDetailView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/6/24.
//

import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let username: String
    @State private var user: User = .ExampleUser
    @State private var avatarImage: UIImage = .avatarPlaceholder
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            HStack {
                GHFAvatarImageView(placeholderImage: Image(uiImage: avatarImage))
                    .padding(.top, 8)
                
                VStack {
                    GHFTitleLabelView(titleText: user.login, textAlignment: .center, fontSize: 16)
                        .padding(.bottom, 5)
                    GHFBodyLabelView(bodyText: user.createdAt, textAlignment: .leading)
                    GHFBodyLabelView(bodyText: user.bio ?? "", textAlignment: .leading)
                }
            }
            .onAppear {
                getUserDetails()
            }
            .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
            .navigationTitle(username)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func getUserDetails() {
        Task {
            do {
                user = try await NetworkManager.shared.getUserDetails(for: username)
                avatarImage = try await NetworkManager.shared.downloadImage(from: user.avatarUrl)
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
        }
    }
}

#Preview {
    UserDetailView(username: "SAllen0400")
}
