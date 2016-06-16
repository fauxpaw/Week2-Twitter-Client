//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/15/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, IdentityProtocol {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        API.shared.getOAuthUser { (user) in
            
            if let currentUser = user {
//                print(user!.name)
//                print(user!.location)
//                self.currentUser = currentUser
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.usernameLabel.text = currentUser.name
                    self.locationLabel.text = currentUser.location
                })
                
            }
            
            else {
                print("this is not the user you are looking for")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonSelected(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
