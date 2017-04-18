//
//  SmashDetailTweetTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/17/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashDetailTweetTableViewController: DetailTweetTableViewController {
    
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    override func insertNewMentions(mentions:[Array<Twitter.Mention>], tweet:Twitter.Tweet){
        updateDatabase(with: mentions, and:tweet)
        
    }
    private func updateDatabase(with mentionsArray: [[Twitter.Mention]], and tweet:Twitter.Tweet ) {
        print("starting database load")
        container?.performBackgroundTask { [weak self] context in
            for mentionsInfo in mentionsArray {
                for mention in mentionsInfo{
                    Mention.createMention(mentionInfo: mention, and:tweet, in: context)
                }
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
                if let mentionsCount = try? context.count(for: Mention.fetchRequest()) {
                    print("\(mentionsCount) Mentions")
                }
            }
        }
    }
    

}
