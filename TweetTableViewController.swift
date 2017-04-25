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
    var tweetViewModel = TweetViewModel()
    var searchText: String? {
        didSet{
            tweetViewModel.searchText = searchText
            tweetViewModel.updateRequest()
            tweetViewModel.searchForTweet()
        }
    }
    
    //    func insertTweets(){
    //       tableView.reloadData()
    //    }
    //
    //    func searchForTweet(){
    //        if let request = tweetViewModel.twitterRequest{
    //            makeRequest(request: request)
    //        }
    //    }
    //    func makeRequest(request:Request){
    //        request.fetchTweets{ newTweets in
    //            DispatchQueue.main.async{
    //                if !newTweets.isEmpty{
    //                    self.tweetViewModel.tweets.insert(newTweets, at: 0)
    //                    self.insertTweets()
    //                }
    //            }
    //        }
    //
    //    }
    func reloadTableView(){
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweetViewModel.tweets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetViewModel.tweets[section].count
    }
    
    private struct Storyboard{
        static let TweetCellIndentifier = "Tweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIndentifier, for: indexPath)
        let tweet = tweetViewModel.tweets[indexPath.section][indexPath.row]
        if let tweetCell = cell as? TweetTableViewCell{
            tweetCell.tweet = tweet
        }
        return cell
    }
    
    @IBOutlet weak var searchTextField: UITextField!{
        didSet{
            searchTextField.delegate = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchText = textField.text
        title = searchText
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
    }
    
    func getSearchTerms()->Array<String>{
        let searchTerms = defaults.object(forKey: "searchTermArray") as? [String] ?? [String]()
        return searchTerms
    }
}

