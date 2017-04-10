//
//  DetailTweetTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/9/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Twitter

class DetailTweetTableViewController: UITableViewController {
var tweetSelected = Array<Twitter.Tweet>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tweet = tweetSelected
        
//        var tweets = [Array<Twitter.Tweet>](){
//            didSet{
//                tableView.reloadData()
//            }
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    
    
    

    

   
}
