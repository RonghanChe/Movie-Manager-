//
//  FavoritesDetails.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct FavoritesDetails: View {
    @EnvironmentObject var userData: UserData
    
    // Input Parameter
    let movie: Movie
    
    var body: some View {
        Form {
            Group{
                Section(header: Text("Movie Title")) {
                    Text(movie.title)
                }
                Section(header: Text("Movie Poster")) {
                    // Public function getImageFromUrl is given in UtilityFunctions.swift
                    getImageFromUrl(url: "Https://image.tmdb.org/t/p/w500/\(movie.posterFileName)", defaultFilename: "ImageUnavailable")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 300, maxWidth: 500, alignment: .center)
                }
                if (movie.youTubeTrailerId != ""){
                    Section(header: Text("YouTube Movie Trailer")) {
                        NavigationLink(destination:
                                        WebView(url: "http://www.youtube.com/embed/\(movie.youTubeTrailerId)")
                                        .navigationBarTitle(Text("Play Movie Trailer"), displayMode: .inline)
                        ){
                            HStack {
                                Image(systemName: "play.rectangle.fill")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.red)
                                Text("Play YouTube Movie Trailer")
                                    .font(.system(size: 16))
                                    .foregroundColor(.black)
                            }
                            .frame(minWidth: 300, maxWidth: 500, alignment: .leading)
                        }
                        .navigationBarTitle(Text("\(movie.title)"), displayMode: .inline)
                    }
                }
            } //End of Group
            Group{
                Section(header: Text("Movie Overview")){
                    Text(movie.overview)
                }
                Section(header: Text("List Movie Cast Members")) {
                    NavigationLink(destination: showCastMembers) {
                        HStack {
                            Image(systemName: "rectangle.stack.person.crop")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                                .foregroundColor(.blue)
                            Text("List Movie Cast Members")
                                .font(.system(size: 16))
                        }
                    }
                    .frame(minWidth: 300, maxWidth: 500)
                }
                Section(header: Text("Movie Runtime")){
                    let hour = movie.runtime / 60
                    let min = movie.runtime - hour*60
                    Text("\(hour) hours \(min) mins")
                }
                Section(header: Text("Movie Genres")){
                    Text(movie.genres)
                }
                Section(header: Text("Movie Release Date")){
                    Text(movie.releaseDate)
                }
                Section(header: Text("Movie Director")){
                    Text(movie.director)
                }
                Section(header: Text("Movie Top Actors")){
                    Text(movie.actors)
                }
                Section(header: Text("Movie Mpaa Rating")){
                    Text(movie.mpaaRating)
                }
                Section(header: Text("Movie Imdb Rating")){
                    Text(movie.imdbRating)
                }
            } // End of Group
        }   // End of Form
        .navigationBarTitle(Text("Skyfall"), displayMode: .inline)
        .font(.system(size: 14))    // Set font and size for all Text views in the Form
        
    }   // End of body
    
    var showCastMembers: some View {
        self.searchCast()
        return AnyView(CastLists())
    }
    
    func searchCast() {
        
        let query = "\(movie.tmdbID)"
        obtainCastDataFromApi(query: query)
    }
}
