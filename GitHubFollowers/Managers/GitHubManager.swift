//
//  GitHubManager.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/8/24.
//

import Foundation

@Observable
final class GitHubManager {
    var gitHubUser: User = .UnknownUser
    var username: String = ""
    var followers: [Follower] = []
    var refreshFollowerList: Bool = false
    
    init() {
        
    }
}
