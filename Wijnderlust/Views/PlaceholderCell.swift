//
//  PlaceholderCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class PlaceholderCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var timelineIcon: UIImageView!
    @IBOutlet weak var timelinePoint: UIImageView!
    @IBOutlet weak var fullLine: UIView!
    @IBOutlet weak var detachTopLine: UIView!
    @IBOutlet weak var detachBottomLine: UIView!
    @IBOutlet weak var detachTopBottomLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        fullLine.isHidden = true
        detachTopLine.isHidden = true
        detachBottomLine.isHidden = true
        detachTopBottomLine.isHidden = true
        
        
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
    }
    
    //configure from a view model
    func configure(for type: String, at indexPath: IndexPath) {
        switch type {
        case "flights":
            cellImage.image = #imageLiteral(resourceName: " Flight Filled")
            label.text = "Add Flights to Itinerary"
            timelineIcon.image = #imageLiteral(resourceName: "Timeline Flight")
            detachTopLine.isHidden =  false
            return
        case "hotel":
            cellImage.image = #imageLiteral(resourceName: " Hotel Filled")
            label.text = "Add Hotel to Itinerary"
            timelineIcon.image = #imageLiteral(resourceName: "Timeline Hotel")
            timelinePoint.image = nil
            timelinePoint.backgroundColor = nil
            detachBottomLine.isHidden = false
            print("Hotel");
            return
        case "hotelMiddle":
            cellImage.image = #imageLiteral(resourceName: " Hotel Filled")
            label.text = "Add Hotel to Itinerary"
            timelineIcon.image = #imageLiteral(resourceName: "Timeline Hotel")
            timelinePoint.image = nil
            timelinePoint.backgroundColor = nil
            fullLine.isHidden = false
            print("Hotel");
            return
        case "places":
            cellImage.image = #imageLiteral(resourceName: " Itinerary Filled")
            label.text = "Add Places to Itinerary"
            timelineIcon.image = #imageLiteral(resourceName: "Timeline POI")
            detachTopBottomLine.isHidden = false
            print("Itinerary");
            return
        default: return
        }
        
    }

}
