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
    let userId = UserDefaults.standard.getCurrentUserId()
    let user = Auth.auth().currentUser
    @IBOutlet dynamic var firstNameField: UITextField!
    @IBOutlet dynamic var lastNameField: UITextField!
    @IBOutlet dynamic var emailAddressField: UITextField!
    @IBOutlet dynamic var passwordField: UITextField!
    @IBOutlet weak var scrollFieldsView: UIScrollView!
    
    var keyboardMoveConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.underlined()
        lastNameField.underlined()
        emailAddressField.underlined()
        passwordField.underlined()
        
        // Populate User Fields
        // Do any additional setup after loading the view.
        
        //Get Fluffy User Details
        self.ref.child("users").child(userId).child("userData").observe(DataEventType.value, with: { (snapshot) in
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
        
        //Get User Profile Auth Details
        if let user = user {
            if let email = user.email {
                self.emailAddressField.text = "\(email)"
            }
        }
        
        //Keyboard Listener
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        keyboardMoveConstraint = NSLayoutConstraint(item: scrollFieldsView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(keyboardMoveConstraint!)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Kayboard Overlay Behaviour
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        //Get keyboard size
        let keyboardSize = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        //Make the scroll view move up that far
        keyboardMoveConstraint?.constant = -keyboardSize.height
    }

    //MARK: - Save changes button
    
    @IBAction func saveChanges(_ sender: Any) {
        //Get current values of fields
        guard let firstName = self.firstNameField.text else { return }
        guard let lastName = self.lastNameField.text else { return }
        guard let emailAddress = self.emailAddressField.text else { return }
        guard let password = self.passwordField.text else { return }
        
        //Initialise the alert
        let alert = UIAlertController(title: "Save Profile Changes", message: "This will update your profile to: \n Name: \(firstName) \(lastName) \n Email: \(emailAddress)", preferredStyle: .alert)
        
        //Success Save Action
        let saveChangesAction = UIAlertAction(title: "Save Changes", style: .default) { (alert: UIAlertAction!) -> Void in
            //Re-auth User
            guard let user = self.user else { return }
            guard let email = user.email else { return }
            
            //Construct auth credential
            let userCredential = EmailAuthProvider.credential(withEmail: email, password: password)
            
            //Attempt re-auth.
            Auth.auth().currentUser?.reauthenticate(with: userCredential) { error in
                if let error = error?.localizedDescription {
                    self.showAlertWith(title: "Something went wrong!", message: "\(error)")
                } else {
                    // User re-authenticated.
                    //Save name to 'user' in firebase.
                    self.ref.child("users/\(self.userId)/userData/firstName").setValue(firstName)
                    self.ref.child("users/\(self.userId)/userData/lastName").setValue(lastName)
                    self.ref.child("users/\(self.userId)/userData/emailAddress").setValue(emailAddress)
        
                    //Change the emailAddress for the Auth property of the user.
                    Auth.auth().currentUser?.updateEmail(to: emailAddress) { (error) in
                        print(error)
                    }
        
                    //Go back to the profile screen.
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        //Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
        }
        
        alert.addAction(saveChangesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

