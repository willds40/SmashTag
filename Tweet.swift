//
//  Tweet.swift
//  Smashtag
//
//  Created by CS193p Instructor on 2/15/17.
//  Copyright © 2017 Stanford University. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Tweet: NSManagedObject
    
{
    class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) throws -> Tweet
    {
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", twitterInfo.identifier)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "Tweet.findOrCreateTweet -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        let tweet = Tweet(context: context)
        tweet.unique = twitterInfo.identifier
        tweet.text = twitterInfo.text
        tweet.created = twitterInfo.created as NSDate
        tweet.tweeter = try? TwitterUser.findOrCreateTwitterUser(matching: twitterInfo.user, in: context)
        return tweet
    }
    
    class func addMentiontoTweet(matching tweetId: String, in context: NSManagedObjectContext, mentionToSave: Mention) throws {
        var mentionSet = NSMutableSet()
        let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
        request.predicate = NSPredicate(format: "unique = %@", tweetId)
        print("$$$$ ADDING MENTION TO TWEET WITH ID: \(tweetId)")
        do {
            let matches = try context.fetch(request)

            if matches.count > 0 {
                assert(matches.count == 1, "Tweet.findOrCreateTweet -- database inconsistency")
                print("Tweet has been found")
                for tweet in matches{
                    mentionSet =  tweet.mutableSetValue(forKey: "mentions")
                    mentionSet.add(mentionToSave)
                }
            }
        }
    }
    
}









