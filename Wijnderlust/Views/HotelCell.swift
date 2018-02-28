//
//  HotelCell.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 28/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit

class HotelCell: UITableViewCell {
    @IBOutlet weak var containerCell: UIView!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var wineStatusLabel: UILabel!
    @IBOutlet weak var wineStatusImage: UIImageView!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var lineDetachBottom: UIView!
    @IBOutlet weak var lineFullLength: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lineFullLength.isHidden = true
        lineDetachBottom.isHidden = true
        
        
        //Round the image corners
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.hotelImage.frame
        rectShape.position = self.hotelImage.center
        rectShape.path = UIBezierPath(roundedRect: self.hotelImage.bounds, byRoundingCorners: [.topLeft , .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        //Here I'm masking the textView's layer with rectShape layer
        self.hotelImage.layer.mask = rectShape
        
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
    func configure(with viewModel: HotelCellViewModel) {
        startDateLabel.text = viewModel.checkInDate
        endDateLabel.text = viewModel.checkOutDate
        hotelName.text = viewModel.hotelName
        hotelImage.image = viewModel.hotelImage
        
        if viewModel.wineListStatus == true {
            wineStatusImage.image = #imageLiteral(resourceName: " Wine Filled")
            wineStatusLabel.text = "Wine List Available"
        } else {
            wineStatusLabel.text = "Wine List Unavailable"
            wineStatusImage.image = #imageLiteral(resourceName: " Wine Not Filled")
        }
    }

}
