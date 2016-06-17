//
//  User.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/13/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import Foundation

class User {
    //specify properties for user
    let name : String
    let profImageUrl : String
    let location : String
    let screenName: String
    
    init? (json: [String: AnyObject])
    {
        //
        if let name = json["name"] as? String, profImageUrl = json["profile_image_url"] as? String, location = json["location"] as? String, screenName = json["screen_name"] as? String {
            self.name = name
            self.profImageUrl = profImageUrl
            self.location = location
            self.screenName = screenName
        }
        else {
            return nil
        }
    }
}