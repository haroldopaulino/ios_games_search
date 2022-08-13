//
//  ContentView.swift
//
//  Created by Haroldo Paulino on 4/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var gamesListVM = GamesListViewModel()
    @State private var title: String = "Games Search"
    @State private var searchingTerm: String = "search for games (min of 4 characters)"
    @State private var searchText: String = ""
    @State private var pageNumber: Int = 1
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 20)!]
    }
    
    var body: some View {
        NavigationView {
            List(gamesListVM.games, id: \.name) { game in
                HStack {
                    AsyncImage(url: URL(string: game.image.medium_url)
                               , content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 100)
                    }, placeholder: {
                        ProgressView()
                    })
                    Text(game.name)
                }
            }.listStyle(.plain)
                
            .navigationBarTitle(Text(title).font(.subheadline), displayMode: .large)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: searchingTerm)
        .onChange(of: searchText) { value in
            async {
                if !value.isEmpty &&  value.count > 2 {
                    searchingTerm = value
                    await gamesListVM.search(name: value, pageNumber: pageNumber)
                } else {
                    //gamesListVM.games.removeAll()
                    pageNumber = 1
                    title = "Games Search"
                }
            }
        }
        .refreshable {
            async {
                pageNumber += 1;
                title = "Listing " + searchingTerm + " - Page " + String(pageNumber)
                await gamesListVM.search(name: searchingTerm, pageNumber: pageNumber)
            }
        }
        .onSubmit(of: .search) {
            dismissSearch()
            dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
