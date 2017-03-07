//
//  ProfileViewController.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 05/03/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User!

   
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tweetCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameLabel.text = "@" + user.screenName!
        self.nameLabel.text = user.name
        self.avatar.setImageWith(user.profileUrl!)
        self.backgroundImage.setImageWith(user.backgroundImageUrl!)
        self.followers.text = "\(user.followersCount!)"
        self.following.text = "\(user.followingCount!)"
        self.tweetCount.text = "\(user.tweetCount!)"
        
        //self.followers = user.
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
