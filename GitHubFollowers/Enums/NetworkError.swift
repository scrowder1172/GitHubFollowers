//
//  NetworkError.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/3/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case urlInvalid
    case statusCodeInvalid
    case responseInvalid
    case gitHubRateLimitExceeded
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .urlInvalid:
            return "This username created an invalid request. Please try again."
        case .statusCodeInvalid:
            return "Invalid response from the server. Please try again."
        case .responseInvalid:
            return "Unable to complete your request. Please check your network connection."
        case .gitHubRateLimitExceeded:
            return "GitHub rate limited exceeded. Please wait before retreiving more details."
        case .other(let error):
            return error.localizedDescription
        }
    }
}
