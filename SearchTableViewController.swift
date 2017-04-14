
import UIKit

class SearchTableViewController: UITableViewController {
    var searchTerms = [String]()
    var searchKeyword = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTerms = SearchTermsRepo.sharedInstance.getSearchTerms()
        searchTerms = searchTerms.reversed()
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    private struct Storyboard{
        static let SearchTermCellIndetifier = "searchTerm"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.SearchTermCellIndetifier, for: indexPath)
        let searchTerm  = searchTerms[indexPath.row]
        
        cell.textLabel?.text = searchTerm
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchTerm  = searchTerms[indexPath.row]
        searchKeyword = searchTerm
        self.performSegue(withIdentifier: "searchSegueRecentSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "searchSegueRecentSearch" {
            let detailViewController = segue.destination as! TweetTableViewController
            detailViewController.searchText = searchKeyword
        }
    }    
}
