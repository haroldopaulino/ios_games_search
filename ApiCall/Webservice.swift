//
//  Webservice.swift
//
//  Created by Haroldo Paulino on 5/1/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badID
}

class Webservice {
    
    func getGames(searchTerm: String, offset: Int) async throws -> [Game] {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "giantbomb.com"
        components.path = "/api/games"
        components.queryItems = [
            URLQueryItem(name: "api_key", value: "f9d1a2846d06a0c620e06ecd8e32700d09981d97"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "field_list", value: "id,guid,image,name"),
            URLQueryItem(name: "limit", value: "10"),
            URLQueryItem(name: "offset", value: String(offset - 1)),
            URLQueryItem(name: "filter", value: "name:" + searchTerm.trim())
        ]
        
        guard let url = components.url else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw NetworkError.badID
        }
        
        let gamesBlank = Games(error: "", limit: 0, offset: 0, number_of_page_results: 0, number_of_total_results: 0, status_code: 0, results: [Game(guid: "", id: 0, image: ImageRecord(icon_url: "", medium_url: "", screen_url: "", screen_large_url: "", small_url: "", super_url: "", thumb_url: "", tiny_url: "", original_url: "", image_tags: ""), name: "")], version: "")
        
        let games = (try? JSONDecoder().decode(Games.self, from: data)) ?? gamesBlank
        return games.results
        
    }
    
}
