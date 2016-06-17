//
//  ProfileViewController.swift
//  TWTR
//
//  Created by Michael Babiy on 6/15/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, Identity
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        API.shared.GETOAuthUser { (user) in
            print(user)
        }
    }
    
    @IBAction func closeButtonSelected(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
