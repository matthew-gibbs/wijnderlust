//
//  ItineraryController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class ItineraryInteriorController: UITableViewController {
    @IBOutlet weak var itineraryTitleLabel: UILabel!
    @IBOutlet weak var itinerarySubtitleLabel: UILabel!
    
    var itinerary: Itinerary?
    var passedDestinationImage: UIImage?
    
    
    lazy var dataSource: ItineraryInteriorDataSource = {
        return ItineraryInteriorDataSource(data: (itinerary)!, tableView: self.tableView)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
        itineraryTitleLabel.text = itinerary?.name.capitalized
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
        if segue.identifier == "showFlight" {
            
        }
    }
}


