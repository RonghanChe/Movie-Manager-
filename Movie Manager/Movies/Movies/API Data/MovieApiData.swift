//
//  MovieApiData.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import Foundation
import SwiftUI

var currentMovieList = [Movie]()

private var movieFound = Movie(id: UUID(), title: "", posterFileName: "", overview: "", genres: "", releaseDate: "", runtime: 0, director: "", actors: "", mpaaRating: "", imdbRating: "", youTubeTrailerId: "", tmdbID: 0)


public func obtainMovieDataFromApi(){
    // tmdb API
    //https://api.themoviedb.org/3/movie/now_playing?api_key=YOUR-API-KEY
    //cc0ce39a581823f0ac740918f8b01924
    let tmdbapiUrl = "https://api.themoviedb.org/3/movie/now_playing?api_key=cc0ce39a581823f0ac740918f8b01924"
    let tmdbjsonDataFromApi = getJsonDataFromApi(apiUrl: tmdbapiUrl)
    do{
        var posterPath = "", overview = "", releaseDate = "", title = "", tmdbID = 0
        let jsonResponse = try JSONSerialization.jsonObject(with: tmdbjsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        var jsonDataDictionary = Dictionary<String, Any>()
        if let jsonObject = jsonResponse as? [String: Any]{
            jsonDataDictionary = jsonObject // da zi dian
            if let attributesArray = jsonDataDictionary["results"] as? [Any]{ //get in results
                for attributes in attributesArray{
                    if let attributeDictionary = attributes as? [String: Any]{
                        if let poster_path = attributeDictionary["poster_path"] as? String{
                            posterPath = poster_path
                            //print(posterPath)
                        }
                        else{
                            posterPath = "nill"
                        }
                        if let ov = attributeDictionary["overview"] as? String{
                            overview = ov
                        }
                        else{
                            overview = "nill"
                        }
                        if let rd = attributeDictionary["release_date"] as? String{
                            releaseDate = rd
                        }
                        else{
                            releaseDate = "nill"
                        }
                        if let t = attributeDictionary["title"] as? String{
                            title = t
                        }
                        else{
                            title = "nill"
                        }
                        if let tmdb_number = attributeDictionary["id"] as? Int{
                            tmdbID = tmdb_number
                        }
                        else{
                            tmdbID = 1
                        }
                        
                        //http://api.themoviedb.org/3/search/movie?api_key=YOUR-API-KEY&query=Jack+Reacher
                        let terms = title.components(separatedBy: " ")
                        var trimmed_title = ""
                        for term in terms{
                            trimmed_title.append("+\(term)")
                        }
                        let tt = trimmed_title.dropFirst()
                        let movieapiUrl = "https://api.themoviedb.org/3/search/movie?api_key=cc0ce39a581823f0ac740918f8b01924&query=\(tt)"
                        let moviejsonDataFromApi = getJsonDataFromApi(apiUrl: movieapiUrl)
                        var movieId = 0
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
                                    } //if let movieattributeDictionary
                                }//End of for
                            }
                        } //if let moviejsonObject =
                        
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
                        movieFound = Movie(id: UUID(), title: title, posterFileName: posterPath, overview: overview, genres: genre, releaseDate: releaseDate, runtime: runtime, director: director, actors: actors, mpaaRating: rate, imdbRating: imdbrating, youTubeTrailerId: video_ID, tmdbID: tmdbID)
                        //print(movieFound)
                        currentMovieList.append(movieFound)
                    }//if let attributeDictionary =
                    
                }//End of for
            }//if let attributesArray =
        }//if let jsonObject =
        else{
            return
        }
    } //End of do
    catch{
        return
    }
}
