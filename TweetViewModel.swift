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
    var tweets = [Array<Twitter.Tweet>]()
    var searchText: String? {
        didSet{
            tweets.removeAll()
            SearchTermsRepo.sharedInstance.setSearchTerms(searchTerm: searchText!)
        }
    }
}


