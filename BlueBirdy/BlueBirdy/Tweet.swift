//
//  Tweet.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 21/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var time: String?
    var retweetCount: Int?
    var favouritesCount: Int?
    var retweeted: Bool?
    var favorited: Bool?
    var id: String?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        let timestamp = dictionary["created_at"] as? String
        
        self.retweeted = dictionary["retweeted"] as? Bool
        self.favorited = dictionary["favorited"] as? Bool
        
        if let timestampString = timestamp{
            let formatter = DateFormatter()
            
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            
            let timeDate = formatter.date(from: timestampString)
            formatter.dateStyle = DateFormatter.Style.short
            formatter.timeStyle = .short
            time = formatter.string(from: timeDate!)
        }
        id = dictionary["id_str"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
            
        }
        
        
        return tweets
    }

}



