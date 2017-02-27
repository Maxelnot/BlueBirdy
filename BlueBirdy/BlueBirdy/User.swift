//
//  User.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 21/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenName: String?
    var profileUrl: URL?
    var tagLine: String?
    var favouritesCount: Int?
    
    static var userDidLogout = "UserLoggedOut"
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        }
        
        tagLine = dictionary["description"] as? String
        favouritesCount = (dictionary["favourites_count"] as? Int) ?? 0
         
    }
    static var _savedUser: User?
    class var savedUser: User?{
        get{
            if _savedUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "savedUserData") as? Data
                if let userData = userData{
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
                    _savedUser = User(dictionary: dictionary)
                    
                }
            }
            return _savedUser
        }
        set(user){
            
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "savedUserData")
            }else{
                defaults.removeObject(forKey: "savedUserData")
            }
            
            defaults.synchronize()
            
            
        }
    }

}
