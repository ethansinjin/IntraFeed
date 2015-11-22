//
//  PostTableViewCell.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    var postID:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func upvote(sender: AnyObject) {
        PostManager.sharedInstance.upvotePost(postID)
    }
    @IBAction func downvote(sender: AnyObject) {
        PostManager.sharedInstance.downvotePost(postID)
    }
}
