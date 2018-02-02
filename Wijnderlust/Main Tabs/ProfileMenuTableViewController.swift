//
//  ProfileMenuTableViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 01/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileMenuTableViewController: UITableViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //Remove the nav bar.
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.backgroundColor = UIColor.white
        
        let id = UserDefaults.standard.getCurrentUserId()
        // Do any additional setup after loading the view.
        
        self.ref.child("users").child(id).child("userData").observe(DataEventType.value, with: { (snapshot) in
            let data = snapshot.value as? [String : AnyObject] ?? [:]
            if let userName = data["firstName"] as? String {
                self.nameLabel.text = "Hello \(userName)"
            }
        })
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */



    // MARK: - Navigation
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Profile Options - EDIT PROFILE
        if indexPath.row == 0 {
            print("Editing Profile")
            self.performSegue(withIdentifier: "editProfileSegue", sender: self)
        }
        //Profile Options - Your Reviews
        else if indexPath.row == 1 {
            print("Your Reviews")
            self.performSegue(withIdentifier: "yourReviewsSegue", sender: self)
        }
        //Profile Options - Trip History
        else if indexPath.row == 2 {
            print("Trip History")
            self.performSegue(withIdentifier: "tripHistorySegue", sender: self)
        }
        //Profile Options - Settings
        else if indexPath.row == 3 {
            print("Setting")
            self.performSegue(withIdentifier: "settingsSegue", sender: self)
        }
        //Profile Options - LOG OUT
        else if indexPath.row == 4 {
            print("Logging Out")
            UserDefaults.standard.setIsLoggedIn(value: false)
            UserDefaults.standard.setCurrentUser(id: "")
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
        
        //Deselect the cell
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
