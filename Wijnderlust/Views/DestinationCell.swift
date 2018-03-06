//
//  DestinationCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 06/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class DestinationCell: UITableViewCell {
    @IBOutlet weak var destinationNameLabel: UILabel!
    @IBOutlet weak var destinationIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with destination: Destination) {
        destinationNameLabel.text = destination.name
        destinationIcon.image = destination.icon
    }

}
