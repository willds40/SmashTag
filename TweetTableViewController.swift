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
        }
    }
    
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
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetViewModel.tweets.count
    }
    
    private struct Storyboard{
        static let TweetCellIndentifier = "Tweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIndentifier, for: indexPath)
        let tweet = tweetViewModel.tweets[indexPath.row]
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Tweeters Mentioning Search Term" {
            if let tweetersTVC = segue.destination as? SmashTweetersTableViewController {
                tweetersTVC.mention = searchText
            }
        }
        if segue.identifier == "detailTweetSegue" {
            
            let detailViewController = segue.destination as! DetailTweetTableViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            
            detailViewController.tweetSelected = tweetViewModel.tweets[row]
        }
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

