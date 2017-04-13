//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Will Devon-Sand on 4/5/17.
//  Copyright © 2017 Will Devon-Sand. All rights reserved.
//

import UIKit
import Twitter

class SearchTermsRepo {
    static let sharedInstance = SearchTermsRepo()
    let defaults = UserDefaults.standard
    var searchTermsArray = [String]()
    
    func setSearchTerms(searchTerm:String){
//        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
//        UserDefaults.standard.synchronize()
        searchTermsArray.append(searchTerm)
        defaults.setValue(searchTermsArray, forKey: "searchTermArray")
        }
    
    func getSearchTerms()->Array<String>{
    let searchTerms = defaults.object(forKey: "searchTermArray") as? [String] ?? [String]()
    return searchTerms
    }
}



class TweetTableViewController: UITableViewController, UITextFieldDelegate {
    
    var tweets = [Array<Twitter.Tweet>](){
        didSet{
            tableView.reloadData()
        }
    }
    var searchText: String? {
        didSet{
            tweets.removeAll()
            searchForTweet()
            title = searchText
        SearchTermsRepo.sharedInstance.setSearchTerms(searchTerm: searchText!)
        }
    }
    
    private var twitterRequest:Twitter.Request?{
        if let query = searchText{
            return Twitter.Request(search: query + "-filter:retweets", count:100)
        }
        return nil
    }
    
    private var lastTwitterRequest:Twitter.Request?
    
    func searchForTweet(){
        if let request = twitterRequest{
            lastTwitterRequest = request
            
            request.fetchTweets{[weak weakSelf = self] newTweets in
                DispatchQueue.main.async{
                    if request == weakSelf?.lastTwitterRequest{
                        if !newTweets.isEmpty{
                            weakSelf?.tweets.insert(newTweets, at:0)
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
    
    
    // MARK: - TableView view data source
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets[section].count
    }
    
    private struct Storyboard{
        static let TweetCellIndentifier = "Tweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIndentifier, for: indexPath)
        
        let tweet = tweets[indexPath.section][indexPath.row]
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
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   if segue.identifier == "detailTweetSegue" {
    
        let detailViewController = segue.destination as! DetailTweetTableViewController
    
        let myIndexPath = self.tableView.indexPathForSelectedRow!
        let row = myIndexPath.row
    
        detailViewController.tweetSelected = [tweets[0][row]]
    }
        }
}
