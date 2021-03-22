/*
 **********************************************************
 *   Statement of Compliance with the Stated Honor Code   *
 **********************************************************
 I hereby declare on my honor that:
 
 (1) All work is completely my own in this Assignment.
 (2) I did NOT receive any help about how to develop the assignment app.
 (3) I did NOT give any help to anyone about how to develop the assignment app.
 (4) I did NOT ask questions to Dr. Balci, GTA or UTA about how to develop the assignment app.
 
 I am hereby writing my name as my signature to declare that the above statements are true:
 
 Ronghan Che
 
 **********************************************************
 */

//
//  AppDelegate.swift
//  Delegates
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /*
         *****************************************
         Read Movies data files upon app launch
         *****************************************
         */
        readMoviesDataFiles()
        obtainMovieDataFromApi()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}


