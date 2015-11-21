//
//  Groups.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import Foundation
import Firebase

protocol GroupsDelegate {
    func groupsUpdated()
}

class Groups {
    static let sharedInstance = Groups()
    var delegate:GroupsDelegate?
    
    var groups:[AnyObject] = []
    var groupIDs:[String] = []
    let firebaseGroups = Firebase(url:"https://intrafeed.firebaseio.com/Groups")
    var selectedGroupID:String = ""
    
    init() {
        self.firebaseGroups.observeEventType(FEventType.ChildAdded, withBlock: {
            snapshot in
            print(snapshot.key)
            print(snapshot.value)
            self.groupIDs.append(snapshot.key)
            self.groups.append(snapshot.value)
            
            self.delegate?.groupsUpdated()
        })
    }
}
