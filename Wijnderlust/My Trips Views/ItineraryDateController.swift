//
//  ItineraryDateController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 06/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase

class ItineraryDateController: UITableViewController {
    var ref: DatabaseReference! = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    
    @IBOutlet weak var departureDateLabel: UITextField!
    @IBOutlet weak var returnDateLabel: UITextField!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var saveItineraryButton: UIButton!
    
    
    @IBAction func departureMinDateSet(_ sender: Any) {
        guard let returnDate = returnDate else { return }
        
        departurePicker.maximumDate = returnDate
    }
    @IBAction func returnMinDateSet(_ sender: Any) {
        returnPicker.minimumDate = departureDate
    }
    
    @IBAction func editedAction(_ sender: Any) {
        if let departureDate = departureDateLabel.text, let returnDate = returnDateLabel.text {
            print(departureDate, returnDate, departureDate.count, returnDate.count)
            if returnDate.count > 0 && departureDate.count > 0 {
                saveItineraryButton.isEnabled = true
                saveItineraryButton.alpha = 1
            } else {
                saveItineraryButton.isEnabled = false
                saveItineraryButton.alpha = 0.5
            }
        }
    }
    
    
    let departurePicker = UIDatePicker()
    let returnPicker = UIDatePicker()
    var departureDate: Date = Date()
    var returnDate: Date?
    var destination: Destination?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDepartureDatePicker()
        createReturnDatePicker()
        departureDateLabel.underlined()
        returnDateLabel.underlined()
        
        if let destination = destination {
            destinationLabel.text = destination.name
        }
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
    
    func createDepartureDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(departureDonePressed))
        
        toolbar.setItems([done], animated: false)
        
        departureDateLabel.inputAccessoryView = toolbar
        departureDateLabel.inputView = departurePicker
        
        // format picker for date
        departurePicker.datePickerMode = .date
        departurePicker.minimumDate = departureDate
    }
    
    @objc func departureDonePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: departurePicker.date)
        
        departureDateLabel.text = "\(dateString)"
        departureDate = departurePicker.date
        self.view.endEditing(true)
    }
    
    func createReturnDatePicker() {
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // done button for toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(returnDonePressed))
        
        toolbar.setItems([done], animated: false)
        
        returnDateLabel.inputAccessoryView = toolbar
        returnDateLabel.inputView = returnPicker
        
        // format picker for date
        returnPicker.datePickerMode = .date
    }
    
    @objc func returnDonePressed() {
        // format date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: returnPicker.date)
        
        returnDateLabel.text = "\(dateString)"
        returnDate = returnPicker.date
        self.view.endEditing(true)
    }
    
    //MARK: Itinerary Saving Script
    
    @IBAction func saveItinerary(_ sender: Any) {
        print("Itinerary Saved!!!")
        let newItinerary = Itinerary(name: destination!.name, startDate: departureDate, endDate: returnDate!, origin: Destinations.london.data.name, imageUrl: destination!.image, originImageUrl: Destinations.london.data.image)
        let newId = "\(newItinerary.name)\(newItinerary.startDate)\(newItinerary.endDate)"
        
        self.ref.child("users/\(userId)/itineraries").child(newId).setValue([
            "destination": newItinerary.name,
            "startDate": newItinerary.startDate.description,
            "endDate": newItinerary.endDate.description,
            "origin": newItinerary.origin,
            "originImageUrl": newItinerary.originImageUrl,
            "imageUrl": newItinerary.imageUrl
        ])
    }
}



