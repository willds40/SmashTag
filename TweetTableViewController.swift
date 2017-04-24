//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/5/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    var viewModel = TweetViewModel()
    let twitterAdapter = TwitterAdapter()
    var searchText: String? {
        didSet{
            viewModel.searchText = searchText
            searchForTweet()
        }
    }

    func insertTweets(_newTweets: [Twitter.Tweet]){
    }
    
    func searchForTweet(){
        twitterAdapter.searchForTweet()
        twitterAdapter.searchText = viewModel.searchText
        if let request = twitterAdapter.twitterRequest{
            twitterAdapter.lastTwitterRequest = request
            request.fetchTweets{[weak weakSelf = self] newTweets in
                DispatchQueue.main.async{
                    if request == weakSelf?.twitterAdapter.lastTwitterRequest{
                        if !newTweets.isEmpty{
                            self.insertTweets(_newTweets: newTweets)
                        }
                    }
                }
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.tweets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweets[section].count
    }
    
    private struct Storyboard{
        static let TweetCellIndentifier = "Tweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIndentifier, for: indexPath)
        let tweet = viewModel.tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell{
            tweetCell.tweet = tweet
        }
        return cell
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{searchTextField.delegate = self
            searchTextField.text = viewModel.searchText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.searchText = textField.text
        title = viewModel.searchText
        searchForTweet()
        return true
    }
}
class SearchTermsRepo {
    static let sharedInstance = SearchTermsRepo()
    let defaults = UserDefaults.standard
    
    func setSearchTerms(searchTerm:String){
        var searchTermsArray = [String]()
        searchTermsArray.append(contentsOf:defaults.object(forKey: "searchTermArray") as? [String] ?? [String]())
        searchTermsArray.append(searchTerm)
        defaults.setValue(searchTermsArray, forKey: "searchTermArray")
        print("Hello")
    }
    
    func getSearchTerms()->Array<String>{
        let searchTerms = defaults.object(forKey: "searchTermArray") as? [String] ?? [String]()
        return searchTerms
    }
}

