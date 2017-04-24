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
    let twitterAdapterVC = TwitterAdapter()
    var viewModel = TweetViewModel()
    
    var searchText: String? {
        didSet{
            //viewModel.tweets.removeAll()
            twitterAdapterVC.searchText = searchText
            searchForTweet()
            title = searchText
     // SearchTermsRepo.sharedInstance.setSearchTerms(searchTerm: searchText!)
        }
    }
    
    func insertTweets(_newTweets: [Twitter.Tweet]){
    viewModel.tweets.insert(_newTweets, at:0)
    tableView.reloadData()
    }
    
    func searchForTweet(){
        if let request = twitterAdapterVC.twitterRequest{
            twitterAdapterVC.lastTwitterRequest = request
            request.fetchTweets{[weak weakSelf = self] newTweets in
                DispatchQueue.main.async{
                    if request == weakSelf?.twitterAdapterVC.lastTwitterRequest{
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
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
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

