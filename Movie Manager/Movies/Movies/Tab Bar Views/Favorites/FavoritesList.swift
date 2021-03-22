//
//  FavoritesList.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct FavoritesList: View {
    
    // Subscribe to changes in UserData
    @EnvironmentObject var userData: UserData
    
    @State private var searchItem = ""
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(searchItem: $searchItem, placeholder: "Search Movies")
                
                ForEach(userData.searchableOrderedMoviesList.filter {self.searchItem.isEmpty ? true : $0.localizedStandardContains(self.searchItem)}, id: \.self)
                { item in
                    NavigationLink(destination: FavoritesDetails(movie: self.searchItemMovie(searchListItem: item)))
                    {
                        FavoriteItem(movie: self.searchItemMovie(searchListItem: item))
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                
            }  // End of List
            .navigationBarTitle(Text("Favorites"), displayMode: .inline)
            
            // Place the Edit button on left of the navigation bar
            .navigationBarItems(leading: EditButton())
            
        }   // End of NavigationView
        .customNavigationViewStyle()  // Given in NavigationStyle.swift
    }
    
    func searchItemMovie(searchListItem: String) -> Movie {
        // Find the index number of moviesList matching the movie attribute 'id'
        let index = userData.moviesList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
        
        return userData.moviesList[index]
    }
    /*
     -------------------------------
     MARK: - Delete Selected Movie
     -------------------------------
     */
    func delete(at offsets: IndexSet) {
        /*
         'offsets.first' is an unsafe pointer to the index number of the array element
         to be deleted. It is nil if the array is empty. Process it as an optional.
         */
        if let index = offsets.first {
            userData.moviesList.remove(at: index)
            userData.searchableOrderedMoviesList.remove(at: index)
        }
        // Set the global variable point to the changed list
        movieStructList = userData.moviesList
        
        // Set the global variable point to the changed list
        orderedSearchableMoviesList = userData.searchableOrderedMoviesList
    }
    
    /*
     -----------------------------
     MARK: - Move Selected Movie
     -----------------------------
     */
    func move(from source: IndexSet, to destination: Int) {
        
        userData.moviesList.move(fromOffsets: source, toOffset: destination)
        userData.searchableOrderedMoviesList.move(fromOffsets: source, toOffset: destination)
        
        // Set the global variable point to the changed list
        movieStructList = userData.moviesList
        
        // Set the global variable point to the changed list
        orderedSearchableMoviesList = userData.searchableOrderedMoviesList
    }
}

