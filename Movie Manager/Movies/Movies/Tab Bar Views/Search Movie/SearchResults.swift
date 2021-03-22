//
//  SearchResults.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct SearchResults: View {
    
    var body: some View {
        List {
            ForEach(searchedMovieList) { aMovie in
                NavigationLink(destination: NowPlayingDetails(movie: aMovie)) {
                    FavoriteItem(movie: aMovie)
                }
            }
        }   // End of List
        
    }   // End of NavigationView
    
}
