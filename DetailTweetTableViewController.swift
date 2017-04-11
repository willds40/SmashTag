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
    var hashtags = Array<Twitter.Mention>()
    var urls = Array<Twitter.Mention>()
    var userMentions = Array<Twitter.Mention>()
    var images = Array<Twitter.MediaItem>()
    var mentions = [Array<Twitter.Mention>]()
    
    

    var tweetSelected = Array<Twitter.Tweet>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        for var hashtag in tweetSelected[0].hashtags{
        hashtags.append(hashtag)
        }
        
        for  var url in tweetSelected[0].urls{
        urls.append(url)
        }
        for  var userMention in tweetSelected[0].urls{
            userMentions.append(userMention)
        }
        
//        for  var images in tweetSelected[0].media{
//            addImages(tweets: [images])
//        }

        
        mentions.append(hashtags)
        mentions.append(urls)
        mentions.append(userMentions)
//        mentions.append(images)
       

}
    
//    private  func addHashtags(tweets:Array<Twitter.Mention> ){
//        for mention in tweets {
//                hashtags.append(mention)
//        }
//        
//        }
//    private  func addUrls(tweets:Array<Twitter.Mention> ){
//        for mention in tweets {
//           urls.append(mention)
//        }
//            }
//    private  func addUserMentions(tweets:Array<Twitter.Mention> ){
//        for mention in tweets {
//           mentions[2].append(mention)
//        }
//           }
//    private  func addImages(tweets:Array<Twitter.MediaItem> ){
//        for mention in tweets {
//            images.append(mention)
//        }
    
//    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return mentions.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of row
        return mentions[section].count
    }

    
    private struct Storyboard{
    static let TweetCellIdentifier = "DetailTweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)
      let mention  = mentions[indexPath.section][indexPath.row]
     cell.textLabel?.text = mention.keyword

        return cell
    }
 

    
    
    

    

   
}
