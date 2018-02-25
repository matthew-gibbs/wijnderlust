//
//  My Trips Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 25/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class MyTripsController: UITableViewController {
    
    var client: DatabaseReference! = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    
    lazy var dataSource: MyTripsDataSource = {
        return MyTripsDataSource(data: [], tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        self.client.child("users").child(userId).child("itineraries").observe(DataEventType.value, with: { (snapshot) in
            
            if (snapshot.childrenCount) > 0 {

            let data = snapshot.children
            
                var itineraries: [Itinerary] = []
                
                for child in data {
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    if let itinerary = Itinerary(json: dict) {
                        itineraries.append(itinerary)
                    }
                }
                
                self.dataSource.update(with: itineraries)
                self.tableView.reloadData()
                
            } else {
                print("No Itineraries")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItinerary" {
            
            }
        }
    }
    

