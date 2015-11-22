//
//  PostsTableViewController.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import UIKit
import ChameleonFramework
import Firebase

class PostsTableViewController: UITableViewController {
    
    var posts:[AnyObject] = []
    var postIDs:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if (self.navigationController?.splitViewController?.collapsed == false) {
//            
//            self.navigationItem.leftBarButtonItem = self.navigationController?.splitViewController?.displayModeButtonItem()
//        }
        
        self.title = Groups.sharedInstance.selectedGroupTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.flatWatermelonColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
       // navigationController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        //navigationItem.leftItemsSupplementBackButton = true
        
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let ref = Firebase(url: "https://intrafeed.firebaseio.com/")
        
        let selectedGroup = Groups.sharedInstance.selectedGroupID
        
        // fetch a list of Posts
        ref.childByAppendingPath("Groups/\(selectedGroup)/Posts").observeEventType(.ChildAdded, withBlock: {snapshot in
            // for each post, fetch the name and print it
            let postKey = snapshot.key
            ref.childByAppendingPath("Posts/\(postKey)").observeSingleEventOfType(.Value, withBlock: {snapshot in
                self.posts.append(snapshot.value)
                self.postIDs.append(snapshot.key)
                self.handleReload()
            })
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleReload() {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("post", forIndexPath: indexPath) as! PostTableViewCell
        cell.postLabel.text = self.posts[indexPath.row]["text"] as? String
        cell.postID = self.postIDs[indexPath.row]
        
        let ups = self.posts[indexPath.row]["Upvotes"] as? [String:Bool]
        let downs = self.posts[indexPath.row]["Downvotes"] as? [String:Bool]
        
        if let realUps = ups {
            if(realUps.keys.contains(User.sharedInstance.currentUserKey)){
                cell.upButton.tintColor = UIColor.flatGreenColor()
                cell.downButton.tintColor = UIColor.lightGrayColor()
                cell.upButton.selected = true
                cell.upButton.enabled = false
                cell.downButton.enabled = false
            }
        } else if let realDowns = downs {
            if (realDowns.keys.contains(User.sharedInstance.currentUserKey)) {
                cell.downButton.tintColor = UIColor.flatRedColor()
                cell.upButton.tintColor = UIColor.lightGrayColor()
                cell.downButton.selected = true
                cell.upButton.enabled = false
                cell.downButton.enabled = false
            }
        }
        
        guard let upScore = ups?.keys.count else {
            cell.scoreLabel.text = "0"
            if let downScore = downs?.keys.count {
                cell.scoreLabel.text = "-" + String(downScore)
            }
            return cell
        }
        guard let downScore = downs?.keys.count else {
            cell.scoreLabel.text = String(upScore)
            return cell
        }
        let score = upScore - downScore
        cell.scoreLabel.text = "\(score)"
        
        // Configure the cell...

        return cell
    }
    

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewControllerWithIdentifier("postDetail") as! PostDetailViewController
        view.postObject = self.posts[indexPath.row]
        view.postID = self.postIDs[indexPath.row]
        self.navigationController?.pushViewController(view, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    

}
