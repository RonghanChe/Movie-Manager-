//
//  CastList.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct CastLists: View {
    
    var body: some View {
        List {
            ForEach(castList) { aCast in
                CastItem(cast: aCast)
            }
        }   // End of List
        
    }   // End of NavigationView
    
}
