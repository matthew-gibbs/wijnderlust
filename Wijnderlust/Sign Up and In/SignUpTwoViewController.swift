//
//  SignUpTwoViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 30/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpTwoViewController: UIViewController {
    var newUser: User?
    var ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet dynamic var EmailField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet dynamic var PasswordField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Push focus into first field.
        EmailField.becomeFirstResponder()
        
        // Make fields underlined.
        EmailField.underlined()
        PasswordField.underlined()
        
        //If have username, customise title
        if let user = newUser {
            if user.firstName != "" {
                TitleLabel.text = "Hello \(user.firstName)!"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



    //Change label colours when the text fields are selected
    @IBAction func EmailStartType(_ sender: Any) {
        EmailLabel.textColor = wijnderlustRed
    }
    
    @IBAction func PasswordStartType(_ sender: Any) {
        PasswordLabel.textColor = wijnderlustRed
    }

    
    //Sign Up Button Action
    @IBAction func SignUp(_ sender: Any) {
        if let email = EmailField.text, let password = PasswordField.text {
            guard !email.isEmpty, !password.isEmpty else {
                self.showAlertWith(title: "Not Enough Data", message: "We need an email and password to make you an account.")
                return
            }
            //TODO: Asbtract this into another file.
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if let u = user {
                    //Populate the user object instance.
                    self.newUser?.id = u.uid
                    self.newUser?.emailAddress = email
                    self.newUser?.password = password
                    
                    //If it's all populated, then do the following.
                    if let newUser = self.newUser {
                        //Add data to firebase DB
                        self.ref.child("users").child(newUser.id).setValue(["userData": newUser.data])
                        //Set local ID and logged in status
                        UserDefaults.standard.setIsLoggedIn(value: true)
                        UserDefaults.standard.setCurrentUser(id: newUser.id)
                    }
                    //Go to home.
                    self.performSegue(withIdentifier: "goHomeSignUp", sender: self)
                } else if let error = error {
                    //FIXME: Nicer error messages for issues.
                    print(error.localizedDescription)
                    self.showAlertWith(title: "Error!", message: "\(error.localizedDescription)")
                }
            })
        }
    }
}
