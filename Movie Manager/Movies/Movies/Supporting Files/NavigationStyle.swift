//
//  NavigationStyle.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

extension View {
    
    public func customNavigationViewStyle() -> some View {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Use single column navigation view for iPhone
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            // Use double column navigation view for iPad
            return AnyView(self
                            .navigationViewStyle(DoubleColumnNavigationViewStyle())
                            .padding(.leading, 1)  // Workaround to show master view until Apple fixes the bug
            )
        }
    }
    
}

