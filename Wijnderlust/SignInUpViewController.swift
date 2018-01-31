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
        // Check if user is signed in.
        if UserDefaults.standard.isLoggedIn() == true {
            self.performSegue(withIdentifier: "isSignedIn", sender: self)
            print("Is signed in")
        } else {
            print("Is not signed in")
//
        }
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
