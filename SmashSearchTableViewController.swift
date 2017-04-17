//
//  SmashSearchTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/17/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class SmashSearchTableViewController: SearchTableViewController {
    
    var container: NSPersistentContainer? =
    (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
//    override func insertTweets(_newTweets newTweets: [Twitter.Tweet]) {
//        super.insertTweets(_newTweets: newTweets)
//        updateDatabase(with: newTweets)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MentionsData"{
            let detailViewController = segue.destination as! SmashTweetersTableViewController
        }
        if  segue.identifier == "searchSegueRecentSearch" {
            let detailViewController = segue.destination as! TweetTableViewController
            detailViewController.searchText = searchKeyword
        }
    }


}
