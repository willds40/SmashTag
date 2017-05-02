import Foundation
import Twitter

class DetailTweetViewModel{
    var mentions = [Array<Any>]()
    
    func addMentions(_ tweetSelected:Twitter.Tweet){
        mentions.append(tweetSelected.media)
        mentions.append(tweetSelected.hashtags)
        mentions.append(tweetSelected.urls)
        mentions.append(tweetSelected.userMentions)
        }
}
