//
//  NowplayingList.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct NowPlayingList: View {
    var body: some View {
        NavigationView{
            List {
                ForEach(currentMovieList) { aMovie in
                    NavigationLink(destination: NowPlayingDetails(movie: aMovie)) {
                        NowPlayingItem(movie: aMovie)
                    }
                }
            }   // End of List
            .navigationBarTitle(Text("Movies Now Playing in Theaters"), displayMode: .inline)
        }
        // End of NavigationView
        
    }
}
