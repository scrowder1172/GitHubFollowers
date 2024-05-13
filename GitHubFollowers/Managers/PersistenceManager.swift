//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by SCOTT CROWDER on 5/8/24.
//

import Foundation

class PersistenceManager {
    
    static var shared = PersistenceManager()
    
    private init() {
        
    }
    
    func loadFavorites() throws -> [Follower] {
        guard let favoritesData = UserDefaults.standard.object(forKey: "favorites") as? Data else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Follower].self, from: favoritesData)
        } catch {
            print("Loading favorites error: \(error.localizedDescription)")
            throw FavoritesError.unableToLoadFavorites
        }
    }
    
    func storeFavorites(favorites: [Follower]) throws {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            UserDefaults.standard.setValue(encodedFavorites, forKey: "favorites")
        } catch {
            print("Error storing favorites: \(error.localizedDescription)")
            throw FavoritesError.unableToSaveFavorites
        }
    }
    
    func saveFavorite(newFavorite: Follower) throws {
        var favorites: [Follower] = try loadFavorites()
        
        guard !favorites.contains(newFavorite) else {
            throw FavoritesError.alreadyFavorited
        }

        do {
            favorites.append(newFavorite)
            try storeFavorites(favorites: favorites)
            
        } catch {
            print("Error saving favorites: \(error.localizedDescription)")
            throw FavoritesError.unableToSaveFavorites
        }
    }
    
    func removeFavorite(at offsets: IndexSet) throws {
        do{
            var favorites: [Follower] = try loadFavorites()
            
            favorites.remove(atOffsets: offsets)
            try storeFavorites(favorites: favorites)
            
        } catch {
            print("Error removing favorites: \(error.localizedDescription)")
            throw FavoritesError.unableToRemoveFavorite
        }
    }
}
