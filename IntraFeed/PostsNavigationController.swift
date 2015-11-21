//
//  PostsNavigationController.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import UIKit

class PostsNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor.flatWatermelonColor()
        navigationBar.translucent = false
        navigationBar.barStyle = UIBarStyle.Black
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        // Do any additional setup after loading the view.
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
        
    }


}
