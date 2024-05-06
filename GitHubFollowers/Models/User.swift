//
//  User.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import Foundation

struct User: Codable, Identifiable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
    
    var id: String { login }
    
    static let ExampleUser: User = User(
        login: "SAllen0400",
        avatarUrl: "https://avatars.githubusercontent.com/u/10645516?v=4",
        publicRepos: 100,
        publicGists: 23,
        htmlUrl: "https://github.com/SAllen0400",
        following: 5,
        followers: 2000,
        createdAt: "2024-03-31 12:00:00 PM"
    )
}
