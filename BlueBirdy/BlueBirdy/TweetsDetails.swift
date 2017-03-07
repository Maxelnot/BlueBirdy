//
//  TweetsDetails.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 28/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class TweetsDetails: UIViewController {
    
    @IBOutlet weak var composeButton: UIBarButtonItem!
    var tweet: Tweet!
    
    @IBOutlet weak var avatarImage: UIImageView!{
        didSet{
            self.avatarImage.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.avatarImage.addGestureRecognizer(userProfileTap)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeButton.target = self
        composeButton.action = #selector(composePressed(sender:))
        
        self.nameLabel.text = tweet.user!.name
        self.usernameLabel.text = "@" + tweet.user!.screenName!
        self.timeLabel.text = tweet.time
        self.tweetTextLabel.text = tweet.text
        self.favoriteCount.text = "\(tweet.favouritesCount!)"
        self.retweetCount.text = "\(tweet.retweetCount!)"
        self.avatarImage.setImageWith(tweet.user!.profileUrl!)
        
        if (self.tweet.retweeted!){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState())
        } else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState())
        }
        
        if (self.tweet.favorited!){
            favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControlState())
        } else {
            favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState())
        }
        
        // Do any additional setup after loading the view.
    }
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController{
                profileVC.user = self.tweet.user! //set the profile user before your push
                self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func composePressed(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let composeVC = storyboard.instantiateViewController(withIdentifier: "ComposeViewController") as? ComposeViewController{
            //composeVC.user = self.user //set the profile user before your push
            self.navigationController?.pushViewController(composeVC, animated: true)
        }
    }
    
    @IBAction func favorPressed(_ sender: UIButton) {
        if (self.tweet.favorited!){
            sender.setImage(UIImage(named:"favor-icon"), for: UIControlState())
            self.favoriteCount.text = "\(tweet.favouritesCount! - 1)"
            BlueBirdyClient.sharedInstance.unfavorite(id: self.tweet.id! , success: {
            }, failure: { (Error) in
            })
            self.tweet.favouritesCount = self.tweet.favouritesCount! - 1
            self.tweet.favorited = false
        }else{
            sender.setImage(UIImage(named:"favor-icon-red"), for: UIControlState())
            self.favoriteCount.text = "\(tweet.favouritesCount! + 1)"
            BlueBirdyClient.sharedInstance.favorite(id: self.tweet.id! , success: {
            }, failure: { (Error) in
            })
            self.tweet.favouritesCount = self.tweet.favouritesCount! + 1
            self.tweet.favorited = true
        }
    }
    
    @IBAction func retweetPressed(_ sender: UIButton) {
        if !(self.tweet.retweeted!){
            sender.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState())
            retweetCount.text = "\(self.tweet.retweetCount! + 1)"
            BlueBirdyClient.sharedInstance.retweet(id: self.tweet.id! , success: {
            }, failure: { (Error) in
            })
            self.tweet.retweetCount = self.tweet.retweetCount! + 1
            self.tweet.retweeted = true
        } else{
            sender.setImage(UIImage(named:"retweet-icon"), for: UIControlState())
            retweetCount.text = "\(self.tweet.retweetCount! - 1)"
            BlueBirdyClient.sharedInstance.unretweet(id: self.tweet.id! , success: {
            }, failure: { (Error) in
            })
            self.tweet.retweetCount = self.tweet.retweetCount! - 1
            self.tweet.retweeted = false
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
