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
    //var tweetSelected = Array<Twitter.Tweet>()
    var mentions = Array<Twitter.Mention>()
    var tweetSelected = Array<Twitter.Tweet>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        for var hashtags in tweetSelected[0].hashtags{
        addMentions(tweets: [hashtags])
        }
        
//        for  var urls in tweetSelected[0].urls{
//        addMentions(tweets: [urls])
//        }
        
//        for var userMentions in tweetSelected[0].userMentions{
//        addMentions(tweets: [userMentions])
//        }

}
    
    private  func addMentions(tweets:Array<Twitter.Mention> ){
        for mention in tweets {
            mentions.append(mention)
        
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        return mentions.count
    }

    
    private struct Storyboard{
    static let TweetCellIdentifier = "DetailTweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)
        let mention = mentions[indexPath.row]
        cell.textLabel?.text = mention.keyword

        return cell
    }
 

    
    
    

    

   
}
