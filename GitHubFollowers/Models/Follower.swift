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
}
