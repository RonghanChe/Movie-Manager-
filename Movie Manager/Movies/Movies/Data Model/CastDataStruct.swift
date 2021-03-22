//
//  MovieDataStruct.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct Cast: Hashable, Codable, Identifiable {
    var id: UUID
    var character: String
    var name: String
    var profile_path: String
}
