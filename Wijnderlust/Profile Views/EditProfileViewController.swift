//
//  EditProfileViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 01/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class EditProfileViewController: UIViewController {
    var ref: DatabaseReference! = Database.database().reference()
    @IBOutlet dynamic var firstNameField: UITextField!
    @IBOutlet dynamic var lastNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.underlined()
        lastNameField.underlined()
        
        // Populate User Fields
        let id = UserDefaults.standard.getCurrentUserId()
        // Do any additional setup after loading the view.
        
        //Get User Details
        self.ref.child("users").child(id).child("userData").observe(DataEventType.value, with: { (snapshot) in
            let data = snapshot.value as? [String : AnyObject] ?? [:]
            
            //Set first name field.
            if let firstName = data["firstName"] as? String {
                self.firstNameField.text = "\(firstName)"
            }
            
            //Set last name field.
            if let lastName = data["lastName"] as? String {
                self.lastNameField.text = "\(lastName)"
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
