//
//  PostDetailViewController.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    var postObject:AnyObject?
    var postID:String?

    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var upScoreLabel: UILabel!
    @IBOutlet weak var downScoreLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        // Do any additional setup after loading the view.
    }
    
    func setupView() {
        if let post = postObject {
            
            self.postLabel.text = post["text"] as? String
            let ups = post["Upvotes"] as? [String:Bool]
            let downs = post["Downvotes"] as? [String:Bool]
            
            
            if let realUps = ups {
                if(realUps.keys.contains(User.sharedInstance.currentUserKey)){
                    self.upButton.tintColor = UIColor.flatGreenColor()
                    self.downButton.tintColor = UIColor.lightGrayColor()
                    self.upButton.selected = true
                    self.upButton.enabled = false
                    self.downButton.enabled = false
                }
            }
            
            if let realDowns = downs {
                if(realDowns.keys.contains(User.sharedInstance.currentUserKey)) {
                    self.downButton.tintColor = UIColor.flatRedColor()
                    self.upButton.tintColor = UIColor.lightGrayColor()
                    self.downButton.selected = true
                    self.upButton.enabled = false
                    self.downButton.enabled = false
                }
            }
            
            guard let upScore = ups?.keys.count else {
                self.scoreLabel.text = "0"
                self.upScoreLabel.text = "Up: 0"
                if let downScore = downs?.keys.count {
                    self.scoreLabel.text = "-" + String(downScore)
                    self.downScoreLabel.text = "Down: " + String(downScore)
                } else {
                    self.downScoreLabel.text = "Down: 0"
                }
                return
            }
            
            self.upScoreLabel.text = "Up: " + String(upScore)
            
            guard let downScore = downs?.count else {
                self.scoreLabel.text = String(upScore)
                self.downScoreLabel.text = "Down: 0"
                return
            }
            
            self.downScoreLabel.text = "Down: " + String(downScore)
            
            let score = upScore - downScore
            self.scoreLabel.text = "\(score)"

        }

    }
    
    @IBAction func upvote(sender: AnyObject) {
        if let postID = self.postID {
            PostManager.sharedInstance.upvotePost(postID)
            
            self.upButton.tintColor = UIColor.flatGreenColor()
            self.downButton.tintColor = UIColor.lightGrayColor()
            self.upButton.selected = true
            self.upButton.enabled = false
            self.downButton.enabled = false
            
            if let score = self.scoreLabel.text {
                if let castedScore = Int(score) {
                    self.scoreLabel.text = String(castedScore + 1)
                }
            }
            
        }
    }
    @IBAction func downvote(sender: AnyObject) {
        if let postID = self.postID {
            PostManager.sharedInstance.downvotePost(postID)
            
            self.downButton.tintColor = UIColor.flatRedColor()
            self.upButton.tintColor = UIColor.lightGrayColor()
            self.downButton.selected = true
            self.upButton.enabled = false
            self.downButton.enabled = false
            
            if let score = self.scoreLabel.text {
                if let castedScore = Int(score) {
                    self.scoreLabel.text = String(castedScore - 1)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "comments" {
            
        }
    }
    

}
