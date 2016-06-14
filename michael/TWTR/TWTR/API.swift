//
//  API.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/14/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import Foundation
import Accounts
import Social


class API {
    
    var account = ACAccount()
    
    private init(){
        
    }
    
    
    func login(){
        
    }
    
    func getOAuthUser(){
        
        
        switch response{
        case 200...299:
            print("yay success")
        case 400...499:
            print("client side error. Code: \(response)")
        case 500...599:
            print("server side error. Code: \(response)")
        default:
            print("\(response): response code unknown")
            
        }
    }
    
    func updateTimeline(){
        
    }
    
    func getTweets(){
        
    }
}