//
//  InspirationController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 07/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

class InspirationController: UITableViewController {
    
    lazy var dataSource: InspirationDataSource = {
        return InspirationDataSource(data: [], tableView: self.tableView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let client = YelpClient()
        client.search(withTerm: "wine bar", at: Coordinate(lat: 51.5033640, long: -0.1276250)) { [weak self] result in
            switch result {
            case .success(let businesses):
                self?.dataSource.update(with: businesses)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

}
