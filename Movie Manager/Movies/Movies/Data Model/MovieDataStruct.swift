//
//  MovieDataStruct.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct Movie: Hashable, Codable, Identifiable {
    var id: UUID
    var title: String
    var posterFileName: String
    var overview: String
    var genres: String
    var releaseDate: String
    var runtime: Int
    var director: String
    var actors: String
    var mpaaRating: String
    var imdbRating: String
    var youTubeTrailerId: String
    var tmdbID: Int
}
