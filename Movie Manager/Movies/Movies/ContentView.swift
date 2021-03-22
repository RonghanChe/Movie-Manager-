//
//  ContentView.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Home()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoritesList()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            NowPlayingList()
                .tabItem{
                    Image(systemName: "rectangle.stack.fill")
                    Text("Now Playing")
                }
            SearchMovies()
                .tabItem{
                    Image(systemName: "magnifyingglass.circle.fill")
                    Text("Movie Search")
                }
            Genres()
                .tabItem{
                    Image(systemName: "list.and.film")
                    Text("Genres")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
