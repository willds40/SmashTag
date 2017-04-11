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
    var hashtags = Array<Twitter.Mention>()
    var urls = Array<Twitter.Mention>()
    var userMentions = Array<Twitter.Mention>()
    var images = Array<Twitter.MediaItem>()
    var mentions = [Array<Any>]()
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
        
        for  var image in tweetSelected[0].media{
            images.append(image)
        }
        
        mentions.append(images)
        mentions.append(hashtags)
        mentions.append(urls)
        mentions.append(userMentions)
    }
    
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
        
        if ((mention as? Twitter.Mention) != nil){
            cell.textLabel?.text = (mention as! Twitter.Mention).keyword
        }else{
            let tweetPicture = getPicture(mention: mention)
            var imageV = UIImageView()
            imageV = cell.imageView!
            imageV.image = tweetPicture
        }
        
        return cell
    }
    
    
    private func getPicture (mention:Any) -> UIImage{
        //should be done on the background thread
        let pictureURL = (mention as! Twitter.MediaItem).url
        let pictureData = NSData(contentsOf: pictureURL as URL)
        let tweetPicture = UIImage(data: pictureData as! Data)
        return tweetPicture!
    }
    
    
    
    
    
    
}
