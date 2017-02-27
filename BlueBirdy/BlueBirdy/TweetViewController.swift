//
//  TweetViewController.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 26/02/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        BlueBirdyClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            
        }) { (error:Error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row] as! Tweet
        
        cell.nameLabel.text = tweet.user!.name
        cell.screenNameLabel.text = tweet.user!.screenName
        cell.timeLabel.text = tweet.time
        cell.tweetTextLabel.text = tweet.text
        cell.favoriteCount.text = "\(tweet.user!.favouritesCount!)"
        cell.retweetCount.text = "\(tweet.retweetCount!)"
        cell.avatar.setImageWith(tweet.user!.profileUrl!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }else{
            return 0
        }
    }
    
    @IBAction func onFavorite(_ sender: UIButton) {
        sender.setImage(UIImage(named:"favor-icon-red"), for: UIControlState())
        
        
    }
   
    @IBAction func onRetweet(_ sender: UIButton) {
        sender.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState())
        
    }
    @IBAction func onLogOut(_ sender: Any) {
        BlueBirdyClient.sharedInstance.logOut()
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
