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
        
        //self.title = Groups.sharedInstance.selectedGroupTitle
        self.navigationController?.navigationBar.barTintColor = UIColor.flatWatermelonColor()
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        
       // navigationController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        //navigationItem.leftItemsSupplementBackButton = true
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // List the names of all Mary's groups
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
        let cell = tableView.dequeueReusableCellWithIdentifier("post", forIndexPath: indexPath)
        cell.textLabel?.text = self.posts[indexPath.row]["text"] as? String
        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
