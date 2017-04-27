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

class SmashDetailTweetTableViewController: DetailTweetTableViewController
{
    var container: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    var fetchedResultsController: NSFetchedResultsController<Tweet>?
    
//    override func insertNewMentions(mentions:[Array<Twitter.Mention>], tweet:Twitter.Tweet){
//        updateDatabase(with: mentions, and:tweet)
//        
//    }
    private func updateDatabase(with mentionsArray: [[Twitter.Mention]], and tweet:Twitter.Tweet ) {
        print("starting database load")

        container?.performBackgroundTask { [weak self] context in
            for mentionsInfo in mentionsArray {
                for mention in mentionsInfo{
                    Mention.createMention(mentionInfo: mention, and:tweet, in: context)
                }
            }
            
            do {
                try context.save()
            } catch {
                print("saving went awry")
            }
            
            print("done loading database")
            self?.printDatabaseStatistics()
        }
        
        if let context = container?.viewContext {
            let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(
                key: "unique",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
                )]

            request.predicate = NSPredicate(format: "unique =  %@", tweet.identifier)
            
            fetchedResultsController = NSFetchedResultsController<Tweet>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            
            try? fetchedResultsController?.performFetch()
            
            let tweet = fetchedResultsController?.object(at: IndexPath(row:0,section:0))
            
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
                if let tweetCount = (try? context.fetch(Tweet.fetchRequest()))?.count {
                    print("\(tweetCount) tweets")
                }
                
                if let mentionsCount = try? context.count(for: Mention.fetchRequest()) {
                    print("\(mentionsCount) Mentions")
                }
            }
        }
    }
}
