//
//  LogInViewController.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 21/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "XUcGsG6u45mLsWLtY1AoKDfMN", consumerSecret: "9kGq5kZAlyaTZqNzCbiMGb29hDvdOXbOkLs56sTvQwcRrHUnhF")!
        
        twitterClient.deauthorize()
        twitterClient.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string:"BlueBirdyDemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential?) -> Void in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(url!)
            
        }) {(error: Error?) -> Void in
            print("error: \(error?.localizedDescription)")
        }
        
        
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
