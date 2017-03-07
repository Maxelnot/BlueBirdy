//
//  TweetCell.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 26/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class  {
    func profileImageViewTapped(cell: TweetCell, user: User)
}

class TweetCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!{
        didSet{
            self.avatar.isUserInteractionEnabled = true //make sure this is enabled
            //tap for userImageView
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.avatar.addGestureRecognizer(userProfileTap)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    weak var delegate: TweetTableViewCellDelegate?
   
    var tweet: Tweet!{
        didSet{
            self.nameLabel.text = tweet.user!.name
            self.screenNameLabel.text = "@" + tweet.user!.screenName!
            self.timeLabel.text = tweet.time
            self.tweetTextLabel.text = tweet.text
            self.favoriteCount.text = "\(tweet.favouritesCount!)"
            self.retweetCount.text = "\(tweet.retweetCount!)"
            self.avatar.setImageWith(tweet.user!.profileUrl!)
        }
    }

    @IBAction func retweetPressed(_ sender: UIButton){
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
    
    func userProfileTapped(_ gesture: UITapGestureRecognizer){
        if let delegate = delegate{
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func favoriteButton(_ sender: UIButton){
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

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
