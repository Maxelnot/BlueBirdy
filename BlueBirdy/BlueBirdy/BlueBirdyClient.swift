//
//  BlueBirdyClient.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 25/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class BlueBirdyClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = BlueBirdyClient(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "XUcGsG6u45mLsWLtY1AoKDfMN", consumerSecret: "9kGq5kZAlyaTZqNzCbiMGb29hDvdOXbOkLs56sTvQwcRrHUnhF")!
    
    var loginSuccess: (() -> ())?
    var loginFail: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFail = failure
        
        self.deauthorize()
        self.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"BlueBirdyDemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            //UIApplication.shared.openURL(url!)
            UIApplication.shared.open(url!, completionHandler: { (true) in})
            
        }) {(error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFail?(error!)
        }

    }
    func logOut(){
        User.savedUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogout), object: nil)
    }
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        self.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAcc(success: { (user: User) in
                print("saved current user")
                User.savedUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) in
                self.loginFail?(error)
            })
            
        }) {(error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFail?(error!)
        }
        
    }
    
    func favorite(id: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        post("1.1/favorites/create.json", parameters: ["id": id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print("Favorite ERROR")
        }
    }
    
    func unfavorite(id: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        post("1.1/favorites/destroy.json", parameters: ["id": id], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print("unfavorite ERROR")
        }
    }
    
    func retweet(id: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print("retweet ERROR")
        }
    }

    func unretweet(id: String, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        post("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
        }) { (task: URLSessionDataTask?, error: Error) in
            print("Unretweet ERROR")
        }
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
    
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func sendTweet(tweetText: String, params: NSDictionary?, completion: @escaping (_ error: Error?) -> ()){
        
        post("1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            completion(nil)
        }) { (task: URLSessionDataTask?,error: Error) in
            print("Error in sending the tweet")
            completion(error as Error?)
        }
        
    }
    
    func currentAcc(success: @escaping  (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            //print("user: \(user)")
            
            success(user)
            /*
            let user = User(dictionary: userDictionary)
            print("name: \(user.name)")
            print("screenname: \(user.screenName)")
            print("profile url: \(user.profileUrl)")
            print("description: \(user.tagLine)")
            */
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
}
