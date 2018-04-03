//
//  SignInUpViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 31/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class SignInUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        // Check if user is signed in.
        if UserDefaults.standard.isLoggedIn() == true {
            self.performSegue(withIdentifier: "isSignedIn", sender: self)
        }
    }
}
