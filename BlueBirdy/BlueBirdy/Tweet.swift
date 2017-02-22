//
//  Tweet.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 21/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var time: Date?
    var retweetCount: Int?
    var favouritesCount: Int?
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        
        let timestamp = dictionary["created_at"] as? String
        
        if let timestampString = timestamp{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            time = formatter.date(from: timestampString)
        }
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favouritesCount = (dictionary["favourties_count"] as? Int) ?? 0
        
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



