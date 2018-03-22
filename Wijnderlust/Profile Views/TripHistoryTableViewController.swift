//
//  TripHistoryTableViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 05/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class TripHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text          = "You Haven't Taken Any Trips Yet!"
        noDataLabel.textColor     = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
        noDataLabel.textAlignment = .center
        tableView.backgroundView  = noDataLabel
        tableView.separatorStyle  = .none
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    

}
