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
    
    //singleton
    static let shared = API()
    var account: ACAccount?
    
    //login function that takes a tuple parameter and returns void
    private func login(completion: (account: ACAccount?)-> ())
    {
        //create instance of ACAccountStore
        let accountStore = ACAccountStore()
        //specify the type of account (in this case twitter)
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        //request access to the account using a closure (callback function)
        accountStore.requestAccessToAccountsWithType(accountType, options: nil, completion: {(granted, error) -> Void in
            
            
            if let _ = error {
                print("Error in accessing account(s)")
                completion(account: nil) //execution of the closure
                return
            }
            
            
            //if user allows access then possible derivitives
            if granted {
                if let userAccount = accountStore.accountsWithAccountType(accountType).first as? ACAccount {
                    completion(account: userAccount)
                    return
                }
                
                //no account found
                print("there are no accounts to draw from! Make a twitter account scrub-noob")
                completion(account: nil)
                return
            }
            
            //when user declines access to their infos
            print("No gun to your head or anything but... If you dont allow access to twitter login info, you cannot utilize our app")
            completion(account: nil)
            return
        })
        
    }
    
    
    
    //looks like we are validating user here after we query the twitter API
    func getOAuthUser(completion: (user: User?)->()){
        
        //need to utilize twitter "GET-request" to validate the credentials of our user. Here we shall specify what a meaningful request should look like
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod:.GET, URL: NSURL(string: "https://api.twitter.com/1.1/account/verify_credentials.json") , parameters: nil)
        
        //must set the account of the user that needs validating to the requested account else we are not passing valid credentials
        request.account = self.account
        
        //we must examine the objects we got back from the twitter API to determine if our user is legit, and/or if there are issues with client or server
        request.performRequestWithHandler{(data, response, error) in
            
            if let _ = error {
                print("SLRequest of type GET could not be completed as dialed. Contact your local operator")
                completion(user: nil)
                return
            }
            
            switch response.statusCode{
            case 200...299:
                print("You did it, you are the best!")
                do {
                    if let userJSON = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [String : AnyObject]{
                        completion(user: User(json: userJSON))
                    }
                } catch {
                    print("ERROR: Could not serialize the young JSON")
                    completion(user: nil)
                }
            case 400...499:
                print("client side error. Code: \(response.statusCode)")
                completion(user: nil)
            case 500...599:
                print("server side error. Code: \(response.statusCode)")
                completion(user: nil)
            default:
                print("\(response.statusCode): response code unknown. Get out your dictionary bruh")
                completion(user: nil)
            }
            
            
        }
        
    }
    
    //second function that will hit the twitter API
    //should check for statuses home timeline
    //requires an array of tweets callback
    func updateTimeline(urlString: String, completion: (tweets: [Tweet]?) -> ()){
        
 print("updating timeline with urlString of \(urlString)")
        
//        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
//                                requestMethod:.GET,
//                                URL: NSURL(string: urlString),
//                                parameters: nil)
        let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, URL: NSURL(string: urlString), parameters: nil)
        
        request.account = self.account
        
        request.performRequestWithHandler { (data, response, error) in
            if let _ = error{
                print("Error: SLRequest type get for user Timeline could not be completed.")
                completion(tweets: nil)
                return
            }
            
            switch response.statusCode{
                
            case 200...299:
                //what is happening right now...
                
                JSONParser.tweetJSONFrom(data, completion: {(success, tweets) in
                    //return to main in async fashion
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(tweets: tweets)
                    })
                })
            case 400...499:
                print("Client Error \(response.statusCode)... You didnt want that anyway")
                completion(tweets: nil)
            case 500...599:
                print("Server Error... You broke it!")
                completion(tweets: nil)
            default:
                print("Error: \(response.statusCode)A wild tyranosaurus appears and begins to sing 'If you're happy and you know it clap your'...oh :(")
                completion(tweets: nil)
            }
            
        }
    }
    
    func getTweets(completion: (tweets: [Tweet]?)-> ()){
        //adjust parameters and arugments for added URL string
        if let _ = self.account{
            self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
        }
        else {
            self.login({ (account) in
                if let account = account {
                    API.shared.account = account
                    self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json", completion: completion)
                }
                else {
                    print("account is nil")
                }
            })
        }
    }
    
    func getUserTweets(userName: String, completion: (tweets: [Tweet]?) -> ())
    {
        
        self.updateTimeline("https://api.twitter.com/1.1/statuses/home_timeline.json?screen_name=\(userName)", completion: completion)
    }
    
    func getImage(urlString: String, completion: (image: UIImage)-> ()) {
        
        //in new queue we will find and extra image data
        NSOperationQueue().addOperationWithBlock {
            guard let url = NSURL(string: urlString) else {return}
            guard let data = NSData(contentsOfURL: url) else {return}
            guard let image = UIImage(data: data) else {return}
            
            //return to main Q with the image so we can update our view
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(image: image)
            })
        }
    }
}