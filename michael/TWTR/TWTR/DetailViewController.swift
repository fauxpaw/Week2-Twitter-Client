//
//  detailViewController.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/15/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, IdentityProtocol {

    var tweet: Tweet?
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tweetLabel.text = "This is my string yo"
        
        
        if let tweet = self.tweet {
            if let retweet = tweet.retweet{
                self.tweetLabel.text = retweet.text
                self.userLabel.text = retweet.user?.name
                print("Im a retweet")
            }
            else {
                self.tweetLabel.text = tweet.text
                self.userLabel.text = tweet.user?.name
                print("normal tweet brah")
            }
            
        }
        else {
            print("what are you doing noob...")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
