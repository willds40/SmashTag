//
//  SmashMentionsTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/18/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import CoreData

class SmashMentionsTableViewController: FetchedResultsTableViewController{

    var searchTerm:String?{ didSet{updateUI()}}
    
    var containter: NSPersistentContainer? =
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
     var fetchedResultsController: NSFetchedResultsController<Mention>?
    
    private func updateUI() {
        if let context = containter?.viewContext,
            let searchTerm = searchTerm {
            let request: NSFetchRequest<Mention> = Mention.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(
                key: "uniqueMention",
                ascending: true,
                selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
                )]
            request.predicate = NSPredicate(format: "any tweet.text contains[c] %@", searchTerm)
            fetchedResultsController = NSFetchedResultsController<Mention>(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            fetchedResultsController?.delegate = self
            try? fetchedResultsController?.performFetch()
            tableView.reloadData()
        }

    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MentionCell", for: indexPath)
        
        if let mention = fetchedResultsController?.object(at: indexPath) {
            if mention.uniqueMention != searchTerm{
                cell.textLabel?.text = mention.uniqueMention
            }
        }
         return cell
    }
}
