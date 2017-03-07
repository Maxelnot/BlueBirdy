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

    @IBOutlet weak var composeButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        composeButton.target = self
        composeButton.action = #selector(composePressed(sender:))
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        self.tableView.insertSubview(refreshControl, at: 0)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
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
        
        
        if (tweet.retweeted!){
            cell.retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControlState())
        } else{
            cell.retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControlState())
        }
        
        if (tweet.favorited!){
            cell.favoriteButton.setImage(UIImage(named:"favor-icon-red"), for: UIControlState())
        } else {
            cell.favoriteButton.setImage(UIImage(named:"favor-icon"), for: UIControlState())
        }
        
        cell.tweet = tweet
       // cell.tweet = App.delegate?.currentUser?.timeline?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets{
            return tweets.count
        }else{
            return 0
        }
    }
    
    func composePressed(sender: UIBarButtonItem){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let composeVC = storyboard.instantiateViewController(withIdentifier: "ComposeViewController") as? ComposeViewController{
            //composeVC.user = self.user //set the profile user before your push
            self.navigationController?.pushViewController(composeVC, animated: true)
        }
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        
        BlueBirdyClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
            
        }) { (error:Error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        BlueBirdyClient.sharedInstance.logOut()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        BlueBirdyClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexpath = self.tableView.indexPath(for: cell)
        let tweet = tweets[indexpath!.row] as Tweet!
        
        let tweetDetails = segue.destination as! TweetsDetails
        tweetDetails.tweet = tweet
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
extension TweetViewController: TweetTableViewCellDelegate{
    func profileImageViewTapped(cell: TweetCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController{
            profileVC.user = user //set the profile user before your push
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}
