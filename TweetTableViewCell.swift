//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/5/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet:Twitter.Tweet?{
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        tweetTextLabel?.attributedText = nil
        tweetCreatedLabel?.attributedText = nil
        tweetCreatedLabel?.attributedText = nil
        tweetProfileImageView?.image = nil
        
        if let tweet = self.tweet{
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media{
                    tweetTextLabel.text! += "📸"
                }
            }
        }
        
        tweetScreenNameLabel?.text = "\(tweet?.user)"
        
        if let profileImageURL = tweet?.user.profileImageURL{
            if let imageData = NSData(contentsOf:profileImageURL){
                tweetProfileImageView?.image = UIImage(data:imageData as Data)
            }
        }
        if let created = tweet?.created{
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created)>24*60*60{
                formatter.dateStyle = .short
            }else{
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from:created)
        }else{
            tweetCreatedLabel?.text = nil
        }
        
    }
    
}

