
import UIKit
import Twitter

class DetailTweetTableViewController: UITableViewController {
    var tweetSelected :Twitter.Tweet!
    var pictureUrl = NSURL()
    var searchKeyword = ""
    var detailTweetViewModel:DetailTweetViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTweetViewModel = DetailTweetViewModel()
        detailTweetViewModel.addMentions(tweetSelected)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return detailTweetViewModel.mentions.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTweetViewModel.mentions[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 && detailTweetViewModel.mentions[section].count != 0 {
            return "Images"
        }
        if section == 1 && detailTweetViewModel.mentions[section].count != 0 {
            return "Hashtags"
        }
        if section == 2 && detailTweetViewModel.mentions[section].count != 0 {
            return "URLS"
        }
        if section == 3 && detailTweetViewModel.mentions[section].count != 0 {
            return "User Mentions"
        }
        return ""
    }
    
    private struct Storyboard{
        static let TweetCellIdentifier = "DetailTweet"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.TweetCellIdentifier, for: indexPath)
        
        let mention  = detailTweetViewModel.mentions[indexPath.section][indexPath.row]
        
        if ((mention as? Twitter.Mention) != nil){
            cell.textLabel?.text = (mention as! Twitter.Mention).keyword
        }else{
            
            DispatchQueue.global().async {
                let pictureURL = (mention as! Twitter.MediaItem).url
                let pictureData = NSData(contentsOf: pictureURL as URL)
                DispatchQueue.main.sync {
                    let tweetPicture = UIImage(data: pictureData as! Data)!
                    var imageV = UIImageView()
                    imageV = cell.viewWithTag(1) as! UIImageView
                    imageV.image = tweetPicture
                    imageV.sizeToFit()
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let mention  = detailTweetViewModel.mentions[indexPath.section][indexPath.row]
            pictureUrl = (mention as! Twitter.MediaItem).url as NSURL
            self.performSegue(withIdentifier: "pictureSegue", sender: self)
        }
        if indexPath.section == 1 {
            let mention  = detailTweetViewModel.mentions[indexPath.section][indexPath.row]
            searchKeyword = (mention as! Twitter.Mention).keyword
            self.performSegue(withIdentifier: "searchSegue", sender: self)
        }
        if indexPath.section == 2 {
            let mention  = detailTweetViewModel.mentions[indexPath.section][indexPath.row]
            if (mention as? Twitter.Mention) != nil{
                let URLString = (mention as! Twitter.Mention).keyword
                let url =  URL(string:URLString)
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                
            }
        }
        if indexPath.section == 3 {
            let mention  = detailTweetViewModel.mentions[indexPath.section][indexPath.row]
            searchKeyword = (mention as! Twitter.Mention).keyword
            self.performSegue(withIdentifier: "searchSegue", sender: self)
        }
        
    }    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "pictureSegue" {
            
            let detailViewController = segue.destination as! PictureViewController
            detailViewController.imageURL = pictureUrl
        }
        if  segue.identifier == "searchSegue" {
            
            let detailViewController = segue.destination as! TweetTableViewController
            detailViewController.searchText = searchKeyword
        }
    }
    
}
