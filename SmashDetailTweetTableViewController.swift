//
//  SmashDetailTweetTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/17/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class SmashDetailTweetTableViewController: DetailTweetTableViewController
{
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    //    override func insertTweets(_newTweets newTweets: [Twitter.Tweet]) {
    //        super.insertTweets(_newTweets: newTweets)
    //        updateDatabase(with: newTweets)
    //    }
    
    private func updateDatabase(with tweets: [Twitter.Tweet]) {
        print("starting database load")
        container?.performBackgroundTask { [weak self] context in
            for twitterInfo in tweets {
                _ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
            }
            try? context.save()
            print("done loading database")
            self?.printDatabaseStatistics()
        }
    }
    
    private func printDatabaseStatistics() {
        if let context = container?.viewContext {
            context.perform {
                if Thread.isMainThread {
                    print("on main thread")
                } else {
                    print("off main thread")
                }
                // bad way to count
                if let tweetCount = (try? context.fetch(Tweet.fetchRequest()))?.count {
                    print("\(tweetCount) tweets")
                }
                // good way to count
                if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest()) {
                    print("\(tweeterCount) Twitter users")
                }
            }
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MentionsData"{
            let detailViewController = segue.destination as! SmashTweetersTableViewController
        }
        
        if  segue.identifier == "pictureSegue" {
            
            let detailViewController = segue.destination as! PictureViewController
            detailViewController.imageURL = pictureUrl
        }
        if  segue.identifier == "searchSegue" {
            
            let detailViewController = segue.destination as! TweetTableViewController
            detailViewController.searchText = searchKeyword
        }
    }
}

    
