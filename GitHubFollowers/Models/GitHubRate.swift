//
//  GitHubRate.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import Foundation

struct GitHubRate: Codable {
    let rate: Rate
}

struct Rate: Codable {
    let limit: Int
    let remaining: Int
}
