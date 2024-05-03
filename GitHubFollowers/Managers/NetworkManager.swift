//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl: String = "https://api.github.com/users/"
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, resultsPerPage: Int = 100) async throws -> [Follower] {
        let endpoint: String = baseUrl + "\(username)/followers?per_page=\(resultsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.urlInvalid
        }
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            throw NetworkError.responseInvalid
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.statusCodeInvalid
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let followers: [Follower] = try decoder.decode([Follower].self, from: data)
            return followers
            
        } catch {
            print("Error: \(error.localizedDescription)")
            throw NetworkError.responseInvalid
        }
        
    }
}
