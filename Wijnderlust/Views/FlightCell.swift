//
//  FlightCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 27/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var flightImage: UIImageView!
    @IBOutlet weak var imageOverlay: UIView!
    @IBOutlet weak var lineDetachBottom: UIView!
    @IBOutlet weak var lineFullLength: UIView!
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var flightNo: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var wineStatusImage: UIImageView!
    @IBOutlet weak var wineStatusLabel: UILabel!
    @IBOutlet weak var airportDestLabel: UILabel!
    @IBOutlet weak var airportDepLabel: UILabel!
    @IBOutlet weak var airportDepCodeLabel: UILabel!
    @IBOutlet weak var airportDestCodeLabel: UILabel!
    @IBOutlet weak var timelinePoint: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineFullLength.isHidden = true
        lineDetachBottom.isHidden = true
        
        
        //Round the image corners
        let rectShape = CAShapeLayer()
        let overlayShape = CAShapeLayer()
        rectShape.bounds = self.flightImage.frame
        rectShape.position = self.flightImage.center
        rectShape.path = UIBezierPath(roundedRect: self.flightImage.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.flightImage.layer.mask = rectShape
        overlayShape.bounds = self.imageOverlay.frame
        overlayShape.position = self.imageOverlay.center
        overlayShape.path = UIBezierPath(roundedRect: self.imageOverlay.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.imageOverlay.layer.mask = overlayShape
        
        //Setup shadow
        containerCell.layer.shadowColor = UIColor.black.cgColor
        containerCell.layer.shadowOpacity = 0.2
        containerCell.layer.cornerRadius = 5
        containerCell.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //configure from a view model
    func configure(with viewModel: FlightCellViewModel) {
        self.departureDate.text = viewModel.departureDate
        self.flightNo.text = viewModel.flightNo
        self.mainLabel.text = viewModel.mainLabel
        
        
        if viewModel.flightType == .outbound {
            self.flightImage.image = viewModel.flightImage
            lineFullLength.isHidden = false
            self.airportDepLabel.text = viewModel.origin
            self.airportDestLabel.text = viewModel.destination
            self.airportDepCodeLabel.text = String(viewModel.origin.prefix(3).uppercased())
            self.airportDestCodeLabel.text = String(viewModel.destination.prefix(3).uppercased())
        } else {
            self.flightImage.image = #imageLiteral(resourceName: "originDefault")
            lineDetachBottom.isHidden = false
            timelinePoint.image = nil
            timelinePoint.backgroundColor = nil
            self.airportDepLabel.text = viewModel.destination
            self.airportDestLabel.text = viewModel.origin
            self.airportDepCodeLabel.text = String(viewModel.destination.prefix(3).uppercased())
            self.airportDestCodeLabel.text = String(viewModel.origin.prefix(3).uppercased())
        }
        
        if viewModel.wineListStatus == true {
            wineStatusImage.image = #imageLiteral(resourceName: " Wine Filled")
            wineStatusLabel.text = "Wine List Available"
        } else {
            wineStatusLabel.text = "Wine List Unavailable"
            wineStatusImage.image = #imageLiteral(resourceName: " Wine Not Filled")
        }
    }
}
