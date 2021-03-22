//
//  CastApiData.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import Foundation
import SwiftUI

var castList = [Cast]()
private var castFound = Cast(id: UUID(), character: "", name: "", profile_path: "")

public func obtainCastDataFromApi(query: String){
    castList = [Cast]()
    // https://api.themoviedb.org/3/movie/343611?api_key=YOUR-API-KEY&append_to_response=credits
    // cc0ce39a581823f0ac740918f8b01924
    let castapiUrl = "https://api.themoviedb.org/3/movie/\(query)?api_key=cc0ce39a581823f0ac740918f8b01924&append_to_response=credits"
    let castjsonDataFromApi = getJsonDataFromApi(apiUrl: castapiUrl)
    do{
        var character = "", name = "", profile_path = ""
        let castjsonResponse = try JSONSerialization.jsonObject(with: castjsonDataFromApi!,
                                                                options: JSONSerialization.ReadingOptions.mutableContainers)
        var castjsonDataDictionary = Dictionary<String, Any>()
        if let castjsonObject = castjsonResponse as? [String: Any]{
            castjsonDataDictionary = castjsonObject // da zi dian
            if let credits = castjsonDataDictionary["credits"] as? [String:Any]{
                if let castsArray = credits["cast"] as? [Any]{
                    for casts in castsArray{
                        if let castsDictionary = casts as? [String: Any]{
                            if let ch = castsDictionary["character"] as? String{
                                character = ch
                            }
                            else{
                                character = "nill"
                            }
                            if let na = castsDictionary["name"] as? String{
                                name = na
                            }
                            else{
                                name = "nill"
                            }
                            if let pr = castsDictionary["profile_path"] as? String{
                                profile_path = pr
                            }
                            else{
                                profile_path = "nill"
                            }
                            castFound = Cast(id: UUID(), character: character, name: name, profile_path: profile_path)
                            castList.append(castFound)
                        }//if let castsDictionary
                    }// end of for
                }//if let castsArray = credits["cast"]
            } // if let credits = castjsonDataDictionary
        }//if let castjsonObject = castjsonResponse as? [String: Any]
        else{
            return
        }
    } //End of do
    catch{
        return
    }
}
