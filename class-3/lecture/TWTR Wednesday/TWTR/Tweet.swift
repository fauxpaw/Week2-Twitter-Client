//
//  Tweet.swift
//  TWTR
//
//  Created by Michael Babiy on 6/13/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import Foundation

class Tweet
{
    let text: String
    let id: String
    let user: User?
    var retweet: Tweet?
    
    init?(json: [String : AnyObject])
    {
        if let text = json["text"] as? String, id = json["id_str"] as? String, user = json["user"] as? [String : AnyObject] {
            self.text = text
            self.id = id
            self.user = User(json: user)
            
            // If the tweet is a retweet, create retweet tweet with user.
            
            if let retweetJSON = json["retweeted_status"] as? [String : AnyObject] {
                if let retweet = Tweet(json: retweetJSON) {
                    self.retweet = retweet
                }
            }
        }
        
        else {
            return nil
        }
    }
}