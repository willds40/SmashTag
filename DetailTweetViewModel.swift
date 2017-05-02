import Foundation
import Twitter
import UIKit

class DetailTweetViewModel{
    var mentions = [Array<Any>]()
    var tweetPicture:UIImage?{
        didSet
        {
            DispatchQueue.main.async{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTable"), object: nil)
            }
        }
    }
        func addMentions(_ tweetSelected:Twitter.Tweet){
        mentions.append(tweetSelected.media)
        mentions.append(tweetSelected.hashtags)
        mentions.append(tweetSelected.urls)
        mentions.append(tweetSelected.userMentions)
        }
    
        func getPicture(url:URL){
        DispatchQueue.global().async {
        let pictureData = NSData(contentsOf: url as URL)
        self.tweetPicture = UIImage(data: pictureData as! Data)!
        }
    }
}
