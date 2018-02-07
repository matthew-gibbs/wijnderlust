//
//  SignUpViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 30/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var FirstNameLabel: UILabel!
    @IBOutlet dynamic var FirstNameField: UITextField!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet dynamic var LastNameField: UITextField!
    @IBOutlet weak var NextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Push focus into first field.
        FirstNameField.becomeFirstResponder()
        
        // Make fields underlined.
        FirstNameField.underlined()
        LastNameField.underlined()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Push user data so far through to next state.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let first = FirstNameField.text, let last = LastNameField.text {
            let user = User(id: "", firstName: first, lastName: last, emailAddress: "", password: "")
            if let stageTwo = segue.destination as? SignUpTwoViewController {
                stageTwo.newUser = user
            }
        }
    }
    
    //Change label colours when the text fields are selected
    @IBAction func FirstNameStartType(_ sender: Any) {
        FirstNameLabel.textColor = wijnderlustRed
    }
    
    @IBAction func LastNameStartType(_ sender: Any) {
        LastNameLabel.textColor = wijnderlustRed
    }
    

    //Stage 1 Next Button Tapped
    @IBAction func NextButtonTapped(_ sender: Any) {
        guard let firstName = FirstNameField.text, !firstName.isEmpty, let lastName = LastNameField.text, !lastName.isEmpty else {
                self.showAlertWith(title: "We need your name.", message: "It's not crucial, but it helps us identify your reviews etc.")
                return
        }
        performSegue(withIdentifier: "signUpStageTwo", sender: self)
    }
    
}


