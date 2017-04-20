//
//  SmashMentionsTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/18/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import CoreData

class SmashMentionsTableViewController:
FetchedResultsTableViewController
{
    var searchTerm:String?{ didSet{updateUI()}}
    var containter: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    var fetchedResultsController: NSFetchedResultsController<Tweet>?
    var uniqueMentions = [String]()
    var context = NSManagedObjectContext()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController?.delegate = self
    }
    
    private func updateUI() {
            if let searchTerm = searchTerm {
            context = (containter?.viewContext)!
            let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(
                key: "unique",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
                )]
            request.predicate = NSPredicate(format: "any text contains[c] %@", searchTerm)
            
            fetchedResultsController = NSFetchedResultsController<Tweet>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            try? fetchedResultsController?.performFetch()
            
            
            
            
             let arrayOfTweets = (fetchedResultsController?.fetchedObjects)!
            for tweet in arrayOfTweets{
                for mention in tweet.mentions!{
                    uniqueMentions.append((mention as! Mention).uniqueMention!)
                }
             uniqueMentions = Array(Set(uniqueMentions))
            }
            
            tableView.reloadData()
        }
    }
    
    private struct Storyboard{
        static let MentionPopularityCellIdentifier = "MentionCell"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        return uniqueMentions.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.MentionPopularityCellIdentifier, for: indexPath)
        let menntionCell = uniqueMentions[indexPath.row]
        cell.textLabel?.text = menntionCell
        let mentionCount = mentionCountByCount(menntionCell)
       
        cell.detailTextLabel?.text = "\(mentionCount) mention\((mentionCount == 1) ? "" : "s")"
        return cell
    }
    
    private func mentionCountByCount(_ mention: String) -> Int {
        let request: NSFetchRequest<Mention> = Mention.fetchRequest()
        request.predicate = NSPredicate(format: "uniqueMention contains[c] %@", mention)
        return (try? context.count(for: request)) ?? 0
    }
}
