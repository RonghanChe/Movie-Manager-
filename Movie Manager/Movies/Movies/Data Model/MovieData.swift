//
//  Movie Data.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import Foundation
import SwiftUI

// Global array of Movie structs
var movieStructList = [Movie]()

/*
 Each orderedSearchableMoviesList element contains
 selected movie attributes separated by vertical lines
 for inclusion in the search by the Search Bar in FavoritesList:
 "id|title|posterFileName|overview|genres|releaseDate|runtime|director|actors|mpaaRating|imdbRating|youTubeTrailerId|tmdbID"
 */
var orderedSearchableMoviesList = [String]()

/*
 *********************************
 MARK: - Read Movies Data Files
 *********************************
 */
public func readMoviesDataFiles() {
    
    var documentDirectoryHasFiles = false
    let moviesDataFullFilename = "MoviesData.json"
    
    // Obtain URL of the MoviesData.json file in document directory on the user's device
    // Global constant documentDirectory is defined in UtilityFunctions.swift
    let urlOfJsonFileInDocumentDirectory = documentDirectory.appendingPathComponent(moviesDataFullFilename)
    
    do {
        /*
         Try to get the contents of the file. The left hand side is
         suppressed by using '_' since we do not use it at this time.
         Our purpose is just to check to see if the file is there or not.
         */
        
        _ = try Data(contentsOf: urlOfJsonFileInDocumentDirectory)
        
        /*
         If 'try' is successful, it means that the CountriesData.json
         file exists in document directory on the user's device.
         ---
         If 'try' is unsuccessful, it throws an exception and
         executes the code under 'catch' below.
         */
        
        documentDirectoryHasFiles = true
        
        /*
         --------------------------------------------------
         |   The app is being launched after first time   |
         --------------------------------------------------
         The MoviesData.json file exists in document directory on the user's device.
         Load it from Document Directory into movieStructList.
         */
        
        // The function is given in UtilityFunctions.swift
        movieStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: moviesDataFullFilename, fileLocation: "Document Directory")
        print("MoviesData is loaded from document directory")
        
    } catch {
        documentDirectoryHasFiles = false
        
        /*
         ----------------------------------------------------
         |   The app is being launched for the first time   |
         ----------------------------------------------------
         The MoviesData.json file does not exist in document directory on the user's device.
         Load it from main bundle (project folder) into movieStructList.
         
         This catch section will be executed only once when the app is launched for the first time
         since we write and read the files in document directory on the user's device after first use.
         */
        
        // The function is given in UtilityFunctions.swift
        movieStructList = decodeJsonFileIntoArrayOfStructs(fullFilename: moviesDataFullFilename, fileLocation: "Main Bundle")
        print("MoviesData is loaded from main bundle")
        
        /*
         -------------------------------------------------------------
         |   Create global variable orderedSearchableMoviesList   |
         -------------------------------------------------------------
         This list has two purposes:
         
         (1) preserve the order of countries according to user's liking, and
         (2) enable search of selected country attributes by the SearchBar in FavoritesList.
         
         Each list element consists of "id|name|alpha2code|capital|languages|currency".
         We chose these attributes separated by vertical lines to be included in the search.
         We separate them with "|" so that we can extract its components separately.
         For example, to obtain the id: list item.components(separatedBy: "|")[0]
         "id|title|posterFileName|overview|genres|releaseDate|runtime|director|actors|mpaaRating|imdbRating|youTubeTrailerId|tmdbID"
         */
        for movie in movieStructList {
            let selectedMovieAttributesForSearch = "\(movie.id)|\(movie.title)|\(movie.posterFileName)|\(movie.overview)|\(movie.genres)|\(movie.releaseDate)|\(movie.runtime)|\(movie.director)|\(movie.actors)|\(movie.mpaaRating)|\(movie.imdbRating)|\(movie.youTubeTrailerId)|\(movie.tmdbID)"
            
            orderedSearchableMoviesList.append(selectedMovieAttributesForSearch)
        }
        
    }   // End of do-catch
    
    /*
     ----------------------------------------
     Read OrderedSearchableMoviesList File
     ----------------------------------------
     */
    if documentDirectoryHasFiles {
        // Obtain URL of the file in document directory on the user's device
        let urlOfFileInDocDir = documentDirectory.appendingPathComponent("OrderedSearchableMoviesList")
        
        // Instantiate an NSArray object and initialize it with the contents of the file
        let arrayFromFile: NSArray? = NSArray(contentsOf: urlOfFileInDocDir)
        
        if let arrayObtained = arrayFromFile {
            // Store the unique id of the created array into the global variable
            orderedSearchableMoviesList = arrayObtained as! [String]
        } else {
            print("OrderedSearchableMoviesList file is not found in document directory on the user's device!")
        }
    }
}

/*
 ********************************************************
 MARK: - Write Movies Data Files to Document Directory
 ********************************************************
 */
public func writeMoviesDataFiles() {
    /*
     --------------------------------------------------------------------------
     Write movieStructList into MoviesData.json file in Document Directory
     --------------------------------------------------------------------------
     */
    
    // Obtain URL of the JSON file into which data will be written
    let urlOfJsonFileInDocumentDirectory: URL? = documentDirectory.appendingPathComponent("MoviesData.json")
    
    // Encode countryStructList into JSON and write it into the JSON file
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(movieStructList) {
        do {
            try encoded.write(to: urlOfJsonFileInDocumentDirectory!)
        } catch {
            fatalError("Unable to write encoded movies data to document directory!")
        }
    } else {
        fatalError("Unable to encode movies data!")
    }
    
    /*
     ------------------------------------------------------
     Write orderedSearchableMoviesList into a file named
     OrderedSearchableMoviesList in Document Directory
     ------------------------------------------------------
     */
    
    // Obtain URL of the file in document directory on the user's device
    let urlOfFileInDocDirectory = documentDirectory.appendingPathComponent("OrderedSearchableMoviesList")
    
    /*
     Swift Array does not yet provide the 'write' function, but NSArray does.
     Therefore, typecast the Swift array as NSArray so that we can write it.
     */
    
    (orderedSearchableMoviesList as NSArray).write(to: urlOfFileInDocDirectory, atomically: true)
    
    /*
     The flag "atomically" specifies whether the file should be written atomically or not.
     
     If flag atomically is TRUE, the file is first written to an auxiliary file, and
     then the auxiliary file is renamed as OrderedSearchableCountriesList.
     
     If flag atomically is FALSE, the file is written directly to OrderedSearchableCountriesList.
     This is a bad idea since the file can be corrupted if the system crashes during writing.
     
     The TRUE option guarantees that the file will not be corrupted even if the system crashes during writing.
     */
}
