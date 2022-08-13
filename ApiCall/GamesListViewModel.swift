//
//  GamesListViewModel.swift
//
//  Created by Haroldo Paulino on 5/2/22.
//

import Foundation

@MainActor
class GamesListViewModel: ObservableObject {
    
    @Published var games: [GamesViewModel] = []
    
    func search(name: String, pageNumber: Int) async {
        do {
            let games = try await Webservice().getGames(searchTerm: name, offset: pageNumber)
            self.games = games.map(GamesViewModel.init)
            
        } catch {
            print(error)
        }
    }
    
}


struct GamesViewModel {
    
    let game: Game
    
    var guid: String {
        game.guid
    }
    
    var id: Int {
        game.id
    }
    
    var image: ImageRecord {
        game.image
    }
    
    var name: String {
        game.name
    }}
