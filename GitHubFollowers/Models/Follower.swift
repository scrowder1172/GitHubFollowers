//
//  Follower.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import Foundation

struct Follower: Codable, Identifiable {
    var login: String
    var avatarUrl: String
    
    var id: String { login }
    
    static let Example: Follower = Follower(login: "Sample User", avatarUrl: "https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png")
}
