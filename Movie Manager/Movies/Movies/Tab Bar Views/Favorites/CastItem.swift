//
//  CastItem.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct CastItem: View {
    
    // Input Parameter
    let cast: Cast
    
    var body: some View {
        HStack {
            // Public function getImageFromUrl is given in UtilityFunctions.swift
            getImageFromUrl(url: "Https://image.tmdb.org/t/p/w500/\(cast.profile_path)", defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0)
            
            VStack(alignment: .leading) {
                Text(cast.name)
                Text("playing")
                Text(cast.character)
            }
            // Set font and size for the whole VStack content
            .font(.system(size: 14))
            
        }   // End of HStack
    }
}

