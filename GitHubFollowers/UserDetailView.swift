//
//  UserDetailView.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/6/24.
//

import SwiftUI

struct UserDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(GitHubManager.self) private var gitHubManager
    
    let username: String
//    @State private var user: User?
//    @State private var avatarImage: UIImage = .avatarPlaceholder
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = ""
    
    var userCreatedAtMessage: String {
        if gitHubManager.gitHubUser.login != User.UnknownUser.login {
            return "GitHub since \(gitHubManager.gitHubUser.createdAt.convertToDisplayFormat())"
        } else {
            return "Unknown GitHub profile creation date"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30){
                GHFUserInfoHeaderView()
                GHFRepoItemView()
                GHFFollowerItemView()
                Text(userCreatedAtMessage)
                    .font(.body)
                
                Spacer()
            }
            .padding(.horizontal)
            .onAppear {
                getUserDetails()
            }
            .ghfAlert(isShowingAlert: $isShowingAlert, title: "Error!", message: errorMessage, buttonText: "OK")
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
                gitHubManager.gitHubUser = try await NetworkManager.shared.getUserDetails(for: username)
                print("Avatar URL for \(gitHubManager.gitHubUser.login) is \(gitHubManager.gitHubUser.avatarUrl)")
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
        }
    }
}

#Preview {
    UserDetailView(username: "Sallen0400")
        .environment(GitHubManager())
}
