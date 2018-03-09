//
//  NoTripsCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 09/03/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class NoTripsCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //Setup border
        var yourViewBorder = CAShapeLayer()
        containerCell.layer.cornerRadius = 5
        yourViewBorder.strokeColor = wijnderlustRed.cgColor
        yourViewBorder.lineDashPattern = [4, 4]
        yourViewBorder.frame = containerCell.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: containerCell.bounds).cgPath
        containerCell.layer.addSublayer(yourViewBorder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
