//
//  AppDelegate.swift
//  TWTR
//
//  Created by Michael Babiy on 6/13/16.
//  Copyright © 2016 Michael Babiy. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    let cache = Cache<UIImage>(size: 100)

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        return true
    }
}

