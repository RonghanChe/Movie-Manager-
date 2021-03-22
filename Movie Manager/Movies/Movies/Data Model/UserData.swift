//
//  UserData.swift
//  Movie
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import Combine
import SwiftUI

final class UserData: ObservableObject {
    
    let numberOfImagesInSlideShow = 9
    var counter = 0
    var slideShowTimer = Timer()
    
    @Published var moviesList = movieStructList
    @Published var searchableOrderedMoviesList = orderedSearchableMoviesList
    // Publish imageNumber to refresh the View body in Home.swift when it is changed in the slide show
    @Published var imageNumber = 0
    
    // ❎ Subscribe to notification that the managedObjectContext completed a save
    @Published var savedInDatabase =  NotificationCenter.default.publisher(for: .NSManagedObjectContextDidSave)
    
    
    /*
     --------------------------
     MARK: - Scheduling a Timer
     --------------------------
     */
    public func startTimer() {
        // Stop timer if running
        stopTimer()
        
        /*
         Schedule a timer to invoke the fireTimer() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        slideShowTimer = Timer.scheduledTimer(timeInterval: 3,
                                              target: self,
                                              selector: (#selector(fireTimer)),
                                              userInfo: nil,
                                              repeats: true)
    }
    
    public func stopTimer() {
        counter = 0
        slideShowTimer.invalidate()
    }
    
    @objc func fireTimer() {
        counter += 1
        if counter == numberOfImagesInSlideShow {
            counter = 0
        }
        /*
         Each time imageNumber is changed here, the View body in Home.swift will be re-rendered to
         reflect the change since it subscribes to changes in imageNumber as specified above.
         */
        imageNumber = counter
    }
}

