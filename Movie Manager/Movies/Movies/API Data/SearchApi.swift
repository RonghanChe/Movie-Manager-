//
//  SearchApi.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import Foundation
import SwiftUI

var searchedMovieList = [Movie]()
private var searchmovieFound = Movie(id: UUID(), title: "", posterFileName: "", overview: "", genres: "", releaseDate: "", runtime: 0, director: "", actors: "", mpaaRating: "", imdbRating: "", youTubeTrailerId: "", tmdbID: 0)

public func searchMovieAPI(query: String){
    
    searchedMovieList = [Movie]()
    let searchQuery = query.replacingOccurrences(of: " ", with: "+")
    //http://api.themoviedb.org/3/search/movie?api_key=YOUR-API-KEY&query=Jack+Reacher
    let movieapiUrl = "https://api.themoviedb.org/3/search/movie?api_key=cc0ce39a581823f0ac740918f8b01924&query=\(searchQuery)"
    let moviejsonDataFromApi = getJsonDataFromApi(apiUrl: movieapiUrl)
    do{
        var posterPath = "", overview = "", releaseDate = "", title = ""
        var movieId = 0 //tmdbid
        let moviejsonResponse = try JSONSerialization.jsonObject(with: moviejsonDataFromApi!,
                                                                 options: JSONSerialization.ReadingOptions.mutableContainers)
        var moviejsonDataDictionary = Dictionary<String, Any>()
        if let moviejsonObject = moviejsonResponse as? [String: Any]{
            moviejsonDataDictionary = moviejsonObject // da zi dian
            if let movieattributesArray = moviejsonDataDictionary["results"] as? [Any]{
                for movieattributes in movieattributesArray{
                    if let movieattributeDictionary = movieattributes as? [String: Any]{
                        if let movie_number = movieattributeDictionary["id"] as? Int{
                            movieId = movie_number
                        }
                        else{
                            movieId = 1
                        }
                        if let poster_path = movieattributeDictionary["poster_path"] as? String{
                            posterPath = poster_path
                        }
                        else{
                            posterPath = "nill"
                        }
                        if let ov = movieattributeDictionary["overview"] as? String{
                            overview = ov
                        }
                        else{
                            overview = "nill"
                        }
                        if let rd = movieattributeDictionary["release_date"] as? String{
                            releaseDate = rd
                        }
                        else{
                            releaseDate = "nill"
                        }
                        if let t = movieattributeDictionary["title"] as? String{
                            title = t
                        }
                        else{
                            title = "nill"
                        }
                        
                        // https://api.themoviedb.org/3/movie/343611?api_key=YOUR-API-KEY&append_to_response=credits
                        let tmovieapiUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=cc0ce39a581823f0ac740918f8b01924&append_to_response=credits"
                        let tmoviejsonDataFromApi = getJsonDataFromApi(apiUrl: tmovieapiUrl)
                        var imdbId = ""
                        let tmoviejsonResponse = try JSONSerialization.jsonObject(with: tmoviejsonDataFromApi!,
                                                                                  options: JSONSerialization.ReadingOptions.mutableContainers)
                        var tmoviejsonDataDictionary = Dictionary<String, Any>()
                        if let tmoviejsonObject = tmoviejsonResponse as? [String: Any]{
                            tmoviejsonDataDictionary = tmoviejsonObject // da zi dian
                            if let imdb_number = tmoviejsonDataDictionary["imdb_id"] as? String{
                                imdbId = imdb_number
                            }
                            else{
                                imdbId = "nill"
                            }
                        } // if let tmoviejsonObject =
                        
                        // https://api.themoviedb.org/3/movie/284052?api_key=YOUR-API-KEY&append_to_response=videos
                        let videoapiUrl = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=cc0ce39a581823f0ac740918f8b01924&append_to_response=videos"
                        let videojsonDataFromApi = getJsonDataFromApi(apiUrl: videoapiUrl)
                        var runtime = 0, video_ID = ""
                        let videojsonResponse = try JSONSerialization.jsonObject(with: videojsonDataFromApi!,
                                                                                 options: JSONSerialization.ReadingOptions.mutableContainers)
                        var videojsonDataDictionary = Dictionary<String, Any>()
                        if let videojsonObject = videojsonResponse as? [String: Any]{
                            videojsonDataDictionary = videojsonObject // da zi dian
                            if let run_time = videojsonDataDictionary["runtime"] as? Int{
                                runtime = run_time
                            }
                            else{
                                runtime = 1
                            }
                            if let videos = videojsonDataDictionary["videos"] as? [String:Any]{
                                if let resultsArray = videos["results"] as? [Any]{
                                    if resultsArray.isEmpty{
                                        video_ID = ""
                                    }
                                    else{
                                        if let firstindex = resultsArray[0] as? [String:Any]{
                                            if let videoid = firstindex["key"] as? String{
                                                video_ID = videoid
                                            }
                                        }
                                    }//End of else
                                }
                            }//if let videos =
                        } //if let videojsonObject =
                        
                        // http://www.omdbapi.com/?apikey=9f67dd7a&i=tt3393786&plot=full&r=json
                        let othersapiUrl = "https://www.omdbapi.com/?apikey=9f67dd7a&i=\(imdbId)&plot=full&r=json"
                        let othersjsonDataFromApi = getJsonDataFromApi(apiUrl: othersapiUrl)
                        var rate = "", genre = "", director = "", actors = "", imdbrating = ""
                        let othersjsonResponse = try JSONSerialization.jsonObject(with: othersjsonDataFromApi!,
                                                                                  options: JSONSerialization.ReadingOptions.mutableContainers)
                        var othersjsonDataDictionary = Dictionary<String, Any>()
                        if let othersjsonObject = othersjsonResponse as? [String: Any]{
                            othersjsonDataDictionary = othersjsonObject // da zi dian
                            if let rated = othersjsonDataDictionary["Rated"] as? String{
                                rate = rated
                            }
                            else{
                                rate = "nill"
                            }
                            if let ge = othersjsonDataDictionary["Genre"] as? String{
                                genre = ge
                            }
                            else{
                                genre = "nill"
                            }
                            if let di = othersjsonDataDictionary["Director"] as? String{
                                director = di
                            }
                            else{
                                director = "nill"
                            }
                            if let ac = othersjsonDataDictionary["Actors"] as? String{
                                actors = ac
                            }
                            else{
                                actors = "nill"
                            }
                            if let ra = othersjsonDataDictionary["imdbRating"] as? String{
                                imdbrating = ra
                            }
                            else{
                                imdbrating = "nill"
                            }
                        } // if let othersjsonObject =
                        searchmovieFound = Movie(id: UUID(), title: title, posterFileName: posterPath, overview: overview, genres: genre, releaseDate: releaseDate, runtime: runtime, director: director, actors: actors, mpaaRating: rate, imdbRating: imdbrating, youTubeTrailerId: video_ID, tmdbID: movieId)
                        //print(movieFound)
                        searchedMovieList.append(searchmovieFound)
                    } //if let movieattributeDictionary
                }//End of for
            }
        } //if let moviejsonObject =
        else{
            return
        }
    } //End of do
    catch{
        return
    }
}
