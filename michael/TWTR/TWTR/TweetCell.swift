//
//  TweetCell.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/16/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    var cache : Cache<UIImage>? {
        if let delegate = UIApplication.sharedApplication().delegate as? AppDelegate{
            return delegate.cache
        }
        return nil
    }
    
    var tweet: Tweet!{
        didSet {
            self.tweetLabel.text = tweet.text
            
            if let user = self.tweet.user{
                self.userLabel.text = user.screenName
                
                if let image = cache?.read(user.profImageUrl){
                    self.imageLabel.image = image
                    return
                }
                
                API.shared.getImage(user.profImageUrl, completion: { (image) in
                    self.cache?.write(image, key: user.profImageUrl)
                    self.imageLabel.image = image
                })
            }
        }
        
    }
    
    func setupTweetCell() {
        self.imageLabel.clipsToBounds = true
        self.imageLabel.layer.cornerRadius = 10.0
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsetsMake(0.0, 10.0, 0.0, 10.0)
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTweetCell()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
