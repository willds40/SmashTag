//
//  Mentions.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/17/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Mention: NSManagedObject
{
    class func createMentionHashtag(mentionInfo: Twitter.Mention, and tweet:Twitter.Tweet, in context: NSManagedObjectContext){
        let mention = Mention(context: context)
        mention.hashtag = mentionInfo.keyword
        mention.tweet = try? Tweet.findOrCreateTweet(matching: tweet, in: context)
        
    }
    
    class func createMentionUserMentions(mentionInfo: Twitter.Mention,and tweet:Twitter.Tweet, in context: NSManagedObjectContext){
        let mention = Mention(context: context)
        mention.userMention = mentionInfo.keyword
        mention.tweet = try? Tweet.findOrCreateTweet(matching: tweet, in: context)

    }
}



