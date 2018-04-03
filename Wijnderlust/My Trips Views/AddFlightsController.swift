//
//  AddFlightsController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase

class AddFlightsController: UITableViewController {
    
    var itinerary: Itinerary?
    let ref = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    
    @IBAction func dismissAddFlights(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBOutlet weak var outboundFlightField: UITextField!
    @IBOutlet weak var inboundFlightField: UITextField!
    @IBOutlet weak var saveFlightsButton: UIButton!
    @IBAction func saveFlightsAction(_ sender: Any) {
        if let outboundNumber = outboundFlightField.text, let inboundNumber = inboundFlightField.text {
            if let itinerary = self.itinerary {
                let itineraryId = itinerary.id
                
                self.ref.child("users/\(self.userId)/itineraries/\(itineraryId)/flights/outboundNumber").setValue(outboundNumber.uppercased())
                self.ref.child("users/\(self.userId)/itineraries/\(itineraryId)/flights/inboundNumber").setValue(inboundNumber.uppercased())
                
                dismiss(animated: true)
            }
        }
    }
    
    @IBAction func editedAction(_ sender: Any) {
        if let outboundNumber = outboundFlightField.text, let inboundNumber = inboundFlightField.text {
            if outboundNumber.count > 0 && inboundNumber.count > 0 {
                saveFlightsButton.isEnabled = true
                saveFlightsButton.alpha = 1
            } else {
                saveFlightsButton.isEnabled = false
                saveFlightsButton.alpha = 0.5
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outboundFlightField.underlined()
        inboundFlightField.underlined()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
