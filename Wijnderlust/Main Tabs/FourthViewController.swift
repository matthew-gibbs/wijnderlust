//
//  FourthViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase 
import FirebaseDatabase


class FourthViewController: UIViewController {
    @IBOutlet weak var dfdf: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = UserDefaults.standard.getCurrentUserId()
        dfdf.text = id
        // Do any additional setup after loading the view.
        
        self.ref.child("users").child(id).child("userData").observe(DataEventType.value, with: { (snapshot) in
            let data = snapshot.value as? [String : AnyObject] ?? [:]
            self.dataLabel.text = data["firstName"] as? String
            // ...
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.setIsLoggedIn(value: false)
        UserDefaults.standard.setCurrentUser(id: "")
        self.performSegue(withIdentifier: "logOutSegue", sender: self)
    }
}
