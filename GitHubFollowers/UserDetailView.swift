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
    @State private var user: User?
    @State private var avatarImage: UIImage = .avatarPlaceholder
    @State private var isShowingAlert: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                if let user {
                    GHFUserInfoHeaderView(user: user)
                } else {
                    GHFUserInfoHeaderView(user: .UnknownUser)
                }
                
                Spacer()
            }
            .padding(.horizontal)
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
                if let user {
                    print("Avatar URL for \(user.login) is \(user.avatarUrl)")
                }
            } catch {
                errorMessage = error.localizedDescription
                isShowingAlert = true
            }
        }
    }
}

#Preview {
    UserDetailView(username: "buh")
}
