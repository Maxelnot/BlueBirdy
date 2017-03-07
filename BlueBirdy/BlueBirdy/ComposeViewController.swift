//
//  ComposeViewController.swift
//  BlueBirdy
//
//  Created by Cong Tam Quang Hoang on 06/03/17.
//  Copyright © 2017 Cong Tam Quang Hoang. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var user = User._savedUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = "@" + user!.screenName!
        nameLabel.text = user!.name!
        avatar.setImageWith(user!.profileUrl!)
        
        var rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: nil)
        rightBarButtonItem.action = #selector(compose(sender:))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func compose(sender: UIBarButtonItem){
        let tweetText = textView.text
        let paramsDict: NSDictionary = NSDictionary(dictionary: ["status" : tweetText!])
        BlueBirdyClient.sharedInstance.sendTweet(tweetText: textView.text!, params: paramsDict) { (error) in
            print(error?.localizedDescription)
        }
        self.navigationController?.popViewController(animated: true)
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
