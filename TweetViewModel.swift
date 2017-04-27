//
//  TweetViewModel.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/24/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import Foundation
import Twitter
class TweetViewModel {
    var tweets: [Twitter.Tweet] = [] {
        didSet{
            DispatchQueue.main.async{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
            }
        }
    }
    let twitterAdapter = TwitterAdapter()
    var searchText: String? {
        didSet{
            
            tweets.removeAll()
            SearchTermsRepo.sharedInstance.setSearchTerms(searchTerm: searchText!)
            //updateRequest()
            searchForTweet(matching: searchText!)
        }
    }
    
    func searchForTweet(matching searchText:String) {
        twitterAdapter.fetchTweets(matching: searchText, handler: { [weak self] (foundTweets: [Twitter.Tweet]) in
            // I pass along what my scope is!
            self?.tweets = foundTweets
        })
    }
}
