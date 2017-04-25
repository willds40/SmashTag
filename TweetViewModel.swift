//
//  TweetViewModel.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/24/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import Foundation
import Twitter
class TweetViewModel{
    var tweets = [Array<Twitter.Tweet>](){
        didSet{
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
        }
    }
    let twitterAdapter = TwitterAdapter()
    var twitterRequest:Twitter.Request?
    var searchText: String? {
        didSet{
            twitterAdapter.searchText = searchText
            tweets.removeAll()
            SearchTermsRepo.sharedInstance.setSearchTerms(searchTerm: searchText!)
        }
    }
    func updateRequest(){
    twitterAdapter.searchText = searchText
    twitterRequest = twitterAdapter.twitterRequest
    }
    func searchForTweet(){
    if let request = twitterRequest{
    makeRequest(request: request)
    }
    }
    func makeRequest(request:Request){
        request.fetchTweets{ newTweets in
            DispatchQueue.main.async{
                if !newTweets.isEmpty{
                    self.tweets.insert(newTweets, at: 0)
            }
        }
        
    }

}

}
