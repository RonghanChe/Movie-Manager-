//
//  Genres.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//


import SwiftUI

struct Genres: View{
    
    let genresList = ["Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Horror", "Music", "Mystery", "Romance", "Sci-Fi", "Suspense", "Thriller", "War", "Western"]
    @State private var selectedGenre = "Action"
    @EnvironmentObject var userData: UserData
    
    var body: some View{
        NavigationView{
            ZStack{
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack{
                    Divider()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // countryStructList is a global array of Country structs given in TravelGuideData.swift
                            ForEach(genresList, id: \.self) { genre in
                                Button(action: {
                                    self.selectedGenre = genre
                                }) {
                                    VStack {
                                        Image(genre)
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 60.0)
                                        Text(genre)
                                            .fixedSize()
                                            .foregroundColor(genre == self.selectedGenre ? .red : .blue)
                                            .multilineTextAlignment(.center)
                                    }
                                }   // End of Button
                                
                            }   // End of ForEach
                            
                        }   // End of HStack
                        .font(.system(size: 14))
                        
                    }   // End of ScrollView
                    
                    Divider()
                    
                    List{
                        ForEach(userData.searchableOrderedMoviesList.filter {self.selectedGenre.isEmpty ? true : $0.localizedStandardContains(self.selectedGenre)}, id: \.self)
                        { item in
                            NavigationLink(destination: NowPlayingDetails(movie: self.searchItemMovie(searchListItem: item)))
                            {
                                FavoriteItem(movie: self.searchItemMovie(searchListItem: item))
                            }
                        }
                    } // end of List 
                    .navigationBarTitle(Text("Genre List of Movies"), displayMode: .inline)
                } // end of VStack
            }//end of ZStack
        } // end of NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }// end of body
    func searchItemMovie(searchListItem: String) -> Movie {
        // Find the index number of moviesList matching the movie attribute 'id'
        let index = userData.moviesList.firstIndex(where: {$0.id.uuidString == searchListItem.components(separatedBy: "|")[0]})!
        
        return userData.moviesList[index]
    }
}
