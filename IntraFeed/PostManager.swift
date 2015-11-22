//
//  PostManager.swift
//  IntraFeed
//
//  Created by Ethan Gill on 11/21/15.
//  Copyright © 2015 Ethan Gill. All rights reserved.
//

import Foundation
import Firebase

class PostManager {
    static let sharedInstance = PostManager()
    
    func sendPost(text:String, anonymous:Bool, group:String){
        
        let userID = User.sharedInstance.currentUserKey
        let date = NSDate().timeIntervalSince1970
        
        let ref = Firebase(url: "https://intrafeed.firebaseio.com/")

        let postRef = ref.childByAppendingPath("Posts")
        let post = [
            "date": date,
            "text": text,
            "user" : userID,
            "anonymous" : anonymous
        ]
        let post1Ref = postRef.childByAutoId()
        post1Ref.setValue(post)
        
        let postKey:String = post1Ref.key;
        
        let groups = ref.childByAppendingPath("Groups/\(group)/Posts/\(postKey)")
        groups.setValue(true)
        
        let users = ref.childByAppendingPath("Users/\(userID)/Posts/\(postKey)")
        users.setValue(true)
        
//        var post = posts.push({"Users":{user:true},"date":1448125568,"downScore":downScore,"text":text,"upScore":upScore}).key();
//        
//        var groups= myDataRef.child('Groups/'+group+'/Posts');
//        groups.child(post).set(true);
//        var users = myDataRef.child('Users/'+user+'/Posts');
//        users.child(post).set(true);
    }
    
    func upvotePost(postID:String){
        
        let userID = User.sharedInstance.currentUserKey
        let ref = Firebase(url: "https://intrafeed.firebaseio.com/")
        
        let postRef = ref.childByAppendingPath("Posts/\(postID)")
        let downvoteRef = postRef.childByAppendingPath("Downvotes/\(userID)")
        let upvoteRef = postRef.childByAppendingPath("Upvotes/\(userID)")
        downvoteRef.removeValue()
        upvoteRef.setValue(true)
        
    }
    
    func downvotePost(postID:String){
        
        let userID = User.sharedInstance.currentUserKey
        let ref = Firebase(url: "https://intrafeed.firebaseio.com/")
        
        let postRef = ref.childByAppendingPath("Posts/\(postID)")
        let downvoteRef = postRef.childByAppendingPath("Downvotes/\(userID)")
        let upvoteRef = postRef.childByAppendingPath("Upvotes/\(userID)")
        upvoteRef.removeValue()
        downvoteRef.setValue(true)
        
    }
    
    //comments are always anonymous
    func commentOnPost(postID:String, text:String) {
        
        let userID = User.sharedInstance.currentUserKey
        let date = NSDate().timeIntervalSince1970
        
        let ref = Firebase(url: "https://intrafeed.firebaseio.com/")
        
        let postRef = ref.childByAppendingPath("Posts/\(postID)")
        let commentsRef = postRef.childByAppendingPath("Commments")
        let comment = [
            "date": date,
            "text": text,
            "user" : userID,
            "anonymous" : false
        ]
        
        let comment1Ref = commentsRef.childByAutoId()
        comment1Ref.setValue(comment)
        
        let commentKey:String = comment1Ref.key
        
        let users = ref.childByAppendingPath("Users/\(userID)/Comments/\(commentKey)")
        users.setValue(true)
    }
}
