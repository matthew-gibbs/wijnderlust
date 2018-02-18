//
//  AroundMeSearchController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 18/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit


class AroundMeSearchController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var dismissSearchButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchField.becomeFirstResponder()
    }
  
    // MARK: Return Key Behaviour
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()
        return false
    }

    @IBAction func dismissSearch(_ sender: Any) {
        searchField.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @IBAction func searchValueChanged(_ sender: Any) {
        if let searchTerm = searchField.text {
            if searchTerm.count > 0 {
                searchButton.isEnabled = true
                searchButton.alpha = 1
            } else if searchTerm.count == 0 {
                searchButton.isEnabled = false
                searchButton.alpha = 0.5
            }
        }
    }
    
    
}
