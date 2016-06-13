//
//  Tweet.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/13/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import Foundation

class Tweet {
    
    let text: String
    let id: String
    let user: String
    
    init?(json: [String: AnyObject])
    {
        return nil
    }
} 