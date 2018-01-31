//
//  FourthViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    @IBOutlet weak var dfdf: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dfdf.text = UserDefaults.standard.getCurrentUserId()
        // Do any additional setup after loading the view.
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
