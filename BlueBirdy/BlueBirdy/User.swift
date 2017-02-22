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
    
    init(dictionary: NSDictionary){
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        }
        
        tagLine = dictionary["description"] as? String
         
    }

}
