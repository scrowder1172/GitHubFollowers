//
//  FavoritesError.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/8/24.
//

import Foundation

enum FavoritesError: Error, LocalizedError {
    case unableToLoadFavorites
    case unableToSaveFavorites
    case alreadyFavorited
    case unableToRemoveFavorite
    case other(Error)
    
    var errorDescription: String? {
        switch self {
        case .unableToLoadFavorites:
            return "Unable to load favorites"
        case .unableToSaveFavorites:
            return "Unable to save favorites"
        case .alreadyFavorited:
            return "You have already favorited this person. You must really like them 😄"
        case .unableToRemoveFavorite:
            return "Unable to remove favorite"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
