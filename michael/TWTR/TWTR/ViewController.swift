//
//  ViewController.swift
//  TWTR
//
//  Created by Michael Sweeney on 6/13/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupTableView()
        
    }
    
    func setupTableView (){
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.update()
        
        
        
        // Make the call.
        //        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) in
        //            if success {
        //                if let tweets = tweets {
        //                    self.datasource = tweets
        //                    print(tweets)
        //                }
        //            }
        //        }
    }
    
    func update() {
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                self.datasource = tweets
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        print("can a brotha get a segue?")
        if segue.identifier == DetailViewController.id() {
            
            guard let destinationDetailViewController = segue.destinationViewController as? DetailViewController else {return}
            guard let rowDataToSendAt = self.tableView.indexPathForSelectedRow else {return}
            destinationDetailViewController.tweet = self.datasource[rowDataToSendAt.row]
            }
        }
}

extension ViewController : UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let  cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath)
        let tweet = self .datasource[indexPath.row]
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}
