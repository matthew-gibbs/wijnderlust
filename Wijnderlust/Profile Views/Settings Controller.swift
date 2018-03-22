//
//  Settings Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 16/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//        noDataLabel.text = "There are no settings yet!"
//        noDataLabel.textColor = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
//        noDataLabel.textAlignment = .center
//        tableView.backgroundView = noDataLabel
//        tableView.separatorStyle = .none
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    

}
