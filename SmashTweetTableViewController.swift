//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by CS193p Instructor on 2/15/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController
{
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
//     override func insertTweets() {
//        //tweetViewModel.tweets.insert(newTweets, at:0)
//        tableView.reloadData()
//        //updateDatabase(with: newTweets)
//        
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "Tweeters Mentioning Search Term" {
//            if let tweetersTVC = segue.destination as? SmashTweetersTableViewController {
//                tweetersTVC.mention = searchText
//                tweetersTVC.container = container
//            }
//        }
//        if segue.identifier == "detailTweetSegue" {
//            
//            let detailViewController = segue.destination as! DetailTweetTableViewController
//            
//            let myIndexPath = self.tableView.indexPathForSelectedRow!
//            let row = myIndexPath.row
//            
//            detailViewController.tweetSelected = tweetViewModel.tweets
//            }
//    }
}
