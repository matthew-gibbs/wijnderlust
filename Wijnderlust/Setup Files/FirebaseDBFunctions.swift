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


