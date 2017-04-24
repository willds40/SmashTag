import Twitter
import Foundation
class TwitterAdapter {
    var searchText:String?
    var twitterRequest:Twitter.Request?{
        if let query = searchText{
            return Twitter.Request(search: query + "-filter:retweets", count:100)
        }
        return nil
    }
}
