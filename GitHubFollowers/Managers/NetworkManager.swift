//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl: String = "https://api.github.com/users/"
    static let cache = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    func getFollowers(for username: String, page: Int, resultsPerPage: Int = 100) async throws -> [Follower] {
        let endpoint: String = baseUrl + "\(username)/followers?per_page=\(resultsPerPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            print("URL error")
            throw NetworkError.urlInvalid
        }
        print("URL: \(url)")
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            print("response error")
            throw NetworkError.responseInvalid
        }
        
        
        let rate = try await checkGitHubRateLimit()
        print("GitHub Calls Remaining: \(rate.remaining)")
        if rate.remaining < 10 {
            throw NetworkError.gitHubRateLimitExceeded
        }
        
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            throw NetworkError.statusCodeInvalid
//        }
        
        guard let response = response as? HTTPURLResponse else {
            print("invalid response")
            throw NetworkError.responseInvalid
        }
        
        print("Status code: \(response.statusCode)")
        guard response.statusCode == 200 else {
            print("invalid status code \(response.statusCode)")
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
    
    func downloadImage(from urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
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
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.responseInvalid
        }
        
        return image
    }
    
    func decodeUnknownData(data: Data, encoding: String.Encoding = .utf8) {
        if let string: String = String(data: data, encoding: encoding) {
            print("JSON String: \(string)")
        }
    }
    
    func checkGitHubRateLimit() async throws -> Rate{
        // Need to finish adding this check so that the api rate limit does not get exceeded by application execution
        let urlString: String = "https://api.github.com/rate_limit"
        
        guard let url = URL(string: urlString) else {
            throw NetworkError.urlInvalid
        }
        
        let (data, response): (Data, URLResponse)
        
        do {
            (data, response) = try await URLSession.shared.data(from: url)
        } catch {
            print("response error")
            throw NetworkError.responseInvalid
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("invalid response")
            throw NetworkError.responseInvalid
        }
        guard response.statusCode == 200 else {
            print("invalid status code \(response.statusCode)")
            throw NetworkError.statusCodeInvalid
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let rateData = try decoder.decode(GitHubRate.self, from: data)
            return rateData.rate
            
        } catch {
            print("Error: \(error.localizedDescription)")
            throw NetworkError.responseInvalid
        }
    }
}
