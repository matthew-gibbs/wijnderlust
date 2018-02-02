//
//  FirebaseDBSetup.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 31/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

var ref: DatabaseReference! = Database.database().reference()

func getCurrentUserData(forid id: String) -> [String: AnyObject] {
    var data: [String: AnyObject] = [:]
    
    ref.child("users").child(id).child("userData").observe(DataEventType.value, with: { (snapshot) in
        data = snapshot.value as? [String : AnyObject] ?? [:]
    })
    
    return data
}
//FIXME: Make this Function work.
//func getCurrentUserReviews() -> NSDictionary {
//    let userID = Auth.auth().currentUser?.uid
//    var userReviews: NSDictionary
//    ref.child("users").child(userID!).child("reviews").observeSingleEvent(of: .value, with: { (snapshot) in
//        if let r = snapshot.value as? NSDictionary {
//            userReviews = r
//        }
//    })
//    print("Remember to check output for nil")
//    return userReviews
//}

