//
//  SignInViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 31/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet dynamic var EmailField: UITextField!
    @IBOutlet weak var PasswordLabel: UILabel!
    @IBOutlet dynamic var PasswordField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Push focus into first field.
        EmailField.becomeFirstResponder()
        
        // Make fields underlined.
        EmailField.underlined()
        PasswordField.underlined()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EmailStartType(_ sender: Any) {
        EmailLabel.textColor = wijnderlustRed
    }
    
    @IBAction func PasswordStartType(_ sender: Any) {
        PasswordLabel.textColor = wijnderlustRed
    }
    
    //Sign In Button Action
    @IBAction func SignIn(_ sender: Any) {
        if let email = EmailField.text, let password = PasswordField.text {
            guard !email.isEmpty, !password.isEmpty else {
                self.showAlertWith(title: "Welcome Back...", message: "We need an email and password to get you into your account... It's not rocket science.")
                return
            }
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if let u = user {
                    print(u)
                    //Set local ID and logged in status
                    UserDefaults.standard.setIsLoggedIn(value: true)
                    UserDefaults.standard.setCurrentUser(id: u.uid)
                    self.performSegue(withIdentifier: "goHomeSignIn", sender: self)
                } else if let e = error {
                    print(error!)
                    self.showAlertWith(title: "Error!", message: "\(e.localizedDescription)")
                }
            })
        }
    }
    

}
