//
//  detailViewController.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/15/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, IdentityProtocol {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet?
    
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == UserTimelineViewController.id(){
            
            let userTimelineViewController = segue.destinationViewController as! UserTimelineViewController
            
            userTimelineViewController.tweet = self.tweet
            print("segue to Timeline called")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func profileImage(key: String, completion: (image: UIImage) -> ())
    {
        if let image = cache?.read(key) {
            completion(image: image)
            return
        }
        
        API.shared.getImage(key) { (image) in self.cache?.write(image, key: key)
            completion(image: image)
            return
        }
    }
    
    func setup() {
        if let tweet = self.tweet, user = tweet.user {
            if let originalTweet = tweet.retweet, originalUser = originalTweet.user{
                self.navigationItem.title = "Retweetzors"
                self.tweetLabel.text = originalTweet.text
                self.userLabel.text = originalUser.name
                self.profileImage(user.profImageUrl, completion: { (image) in
                    self.profileImgView.image = image
                })
            }
            else {
                self.navigationItem.title = "OP"
                self.tweetLabel.text = tweet.text
                self.userLabel.text = user.name
                
                self.profileImage(user.profImageUrl, completion: { (image) in
                    self.profileImgView.image = image
                })
                
                
            }
        }
    }
}
