//
//  NowPlayingsItem.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct NowPlayingItem: View {
    
    // Input Parameter
    let movie: Movie
    
    var body: some View {
        HStack {
            // Public function getImageFromUrl is given in UtilityFunctions.swift
            getImageFromUrl(url: "Https://image.tmdb.org/t/p/w500/\(movie.posterFileName)", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0)
            
            VStack(alignment: .leading) {
                Text(movie.title)
                HStack {
                    Image("IMDb")
                    Text(movie.imdbRating)
                }
                Text(movie.actors)
                HStack{
                    Text(movie.mpaaRating)
                    Text("\(movie.runtime) mins")
                    Text(movie.releaseDate)
                }
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
}

