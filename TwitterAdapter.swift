import Twitter
import Foundation
class TwitterAdapter {
    var tweets: [Twitter.Tweet] = []
    
    func fetchTweets(matching searchText: String, handler: @escaping ([Twitter.Tweet]) -> Void) {
        buildRequest(for: searchText).fetchTweets(handler)
    }
    
    private func buildRequest(for searchText: String) -> Twitter.Request {
        return Twitter.Request(search: searchText + "-filter:retweets", count:100)
    }
    
  }
 
