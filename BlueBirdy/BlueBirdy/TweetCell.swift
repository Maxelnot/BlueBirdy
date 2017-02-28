//
//  TweetCell.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 26/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
   
    var tweet: Tweet!{
        didSet{
            self.nameLabel.text = tweet.user!.name
            self.screenNameLabel.text = "@" + tweet.user!.screenName!
            self.timeLabel.text = tweet.time
            self.tweetTextLabel.text = tweet.text
            self.favoriteCount.text = "\(tweet.user!.favouritesCount!)"
            self.retweetCount.text = "\(tweet.retweetCount!)"
            self.avatar.setImageWith(tweet.user!.profileUrl!)
        }
    }

    @IBAction func retweetPressed(_ sender: UIButton){
        sender.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState())
        retweetCount.text = "\(self.tweet.retweetCount! + 1)"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func favoriteButton(_ sender: UIButton){
        sender.setImage(UIImage(named:"favor-icon-red"), for: UIControlState())
        self.favoriteCount.text = "\(tweet.user!.favouritesCount! + 1)"
    }

       override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
