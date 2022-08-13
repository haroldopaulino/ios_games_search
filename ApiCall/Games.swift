//
//  Games.swift
//
//  Created by Haroldo Paulino on 5/2/22.
//

import Foundation
import SwiftUI

struct GamesResponse: Decodable {
    let games: [Game]
    
    private enum CodingKeys: String, CodingKey {
        case games = "Search"
    }
}

struct Games: Decodable {
    let error: String
    let limit: Int
    let offset: Int
    let number_of_page_results: Int
    let number_of_total_results: Int
    let status_code: Int
    let results: [Game]
    let version: String
}

struct Game: Decodable {
    let guid: String
    let id: Int
    let image: ImageRecord
    let name: String
    
    private enum CodingKeys: String, CodingKey {
        case guid = "guid"
        case id = "id"
        case image = "image"
        case name = "name"
    }
}

struct ImageRecord: Decodable {
    let icon_url: String
    let medium_url: String
    let screen_url: String
    let screen_large_url: String
    let small_url: String
    let super_url: String
    let thumb_url: String
    let tiny_url: String
    let original_url: String
    let image_tags: String
}
