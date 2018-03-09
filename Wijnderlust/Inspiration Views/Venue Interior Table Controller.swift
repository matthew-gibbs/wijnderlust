//
//  Venue Interior Table Controller.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 11/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//
import Foundation
import UIKit
import MapKit
import Firebase

class VenueInteriorTableController: UITableViewController {
    
    let client = YelpClient()
    let pendingOperations = PendingOperations()
    var ref: DatabaseReference! = Database.database().reference()
    let userId = UserDefaults.standard.getCurrentUserId()
    
    @IBOutlet weak var venueRatingLabel: CosmosView!
    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueCategoryLabel: UILabel!
    @IBOutlet weak var venuePriceLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    @IBOutlet weak var venueLocationOnMap: MKMapView!
    @IBOutlet weak var saveToItineraryButton: UIButton!
    
    //Serving Indicatiors
    @IBOutlet weak var servesWineLabel: UILabel!
    @IBOutlet weak var servesWineImage: UIImageView!
    @IBOutlet weak var servesFoodLabel: UILabel!
    @IBOutlet weak var servesFoodImage: UIImageView!
    @IBOutlet weak var offersRoomsLabel: UILabel!
    @IBOutlet weak var offersRoomsImage: UIImageView!
    
    //Review Cells
    @IBOutlet weak var reviewImageOne: UIImageView!
    @IBOutlet weak var reviewOneName: UILabel!
    @IBOutlet weak var reviewOneContent: UILabel!
    @IBOutlet weak var reviewOneRating: CosmosView!
    
    @IBOutlet weak var reviewImageTwo: UIImageView!
    @IBOutlet weak var reviewTwoName: UILabel!
    @IBOutlet weak var reviewTwoContent: UILabel!
    @IBOutlet weak var reviewTwoRating: CosmosView!
    
    @IBOutlet weak var reviewImageThree: UIImageView!
    @IBOutlet weak var reviewThreeName: UILabel!
    @IBOutlet weak var reviewThreeContent: UILabel!
    @IBOutlet weak var reviewThreeRating: CosmosView!
    
    var passedVenueImage: UIImage?
    
    var venue: Venue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentVenue = venue {
            configure(with: currentVenue)
           
            client.reviews(for: currentVenue) { [weak self] result in
                switch result {
                case .success(let reviews):
                    currentVenue.reviews = reviews
                    self?.configure(with: currentVenue)
                case .failure(let error):
                    print(error)
                }
            }
        }
        
        //MARK: Add To Itinerary Query
        var itineraries: [Itinerary] = []
        
        
        self.ref.child("users").child(userId).child("itineraries").observe(DataEventType.value, with: { (snapshot) in
            
            if (snapshot.childrenCount) > 0 {
                let data = snapshot.children
                
                for child in data {
                    let snap = child as! DataSnapshot
                    let dict = snap.value as! [String: Any]
                    if let itinerary = Itinerary(json: dict) {
                        if itinerary.endDate > Date() {
                            itineraries.append(itinerary)
                        }
                    }
                }
                self.configureAlert(with: itineraries)
                
            } else {
                print("No Itineraries")
                self.configureAlert(with: itineraries)
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //Configure the venue interior.
    func configure(with venue: Venue) {
        //Do image assignment outside of the view controller to avoid redownload.
        guard let interiorImage = passedVenueImage else { return }
        venueImage.image = interiorImage
        
        let viewModel = VenueInteriorViewModel(venue: venue)
        venueNameLabel.text = viewModel.venueName
        venueAddressLabel.text = viewModel.venueAddress
        venueCategoryLabel.text = viewModel.venueType
        venuePriceLabel.text = viewModel.price
        venueRatingLabel.rating = viewModel.venueRating
        
        //Wine Serving Indicator
        if viewModel.servesWine == true {
            servesWineLabel.text = "Serves Wine"
            servesWineImage.image = #imageLiteral(resourceName: " Wine Filled")
        } else {
            servesWineImage.image = #imageLiteral(resourceName: " Wine Not Filled")
            servesWineLabel.text = "No Wine"
            servesWineLabel.textColor = inactiveGrey
        }
        
        //Food Serving Indicator
        if viewModel.servesFood == true {
            servesFoodLabel.text = "Serves Food"
            servesFoodImage.image = #imageLiteral(resourceName: " Dinner Filled")
        } else {
            servesFoodImage.image = #imageLiteral(resourceName: " Dinner Not Filled")
            servesFoodLabel.text = "No Food"
            servesFoodLabel.textColor = inactiveGrey
        }
        
        //Offers Rooms Indicator
        if viewModel.offersRooms == true {
            offersRoomsImage.image = #imageLiteral(resourceName: " Hotel Filled")
            offersRoomsLabel.text = "Offers Rooms"
        } else {
            offersRoomsImage.image = #imageLiteral(resourceName: " Hotel Not Filled")
            offersRoomsLabel.text = "No Rooms"
            offersRoomsLabel.textColor = inactiveGrey
        }
        
        //Set up the map
        adjustMap(with: viewModel.location, on: venueLocationOnMap)
        venueLocationOnMap.addAnnotation(venue)
        
        if !(venue.reviews.isEmpty) {
            print(venue.reviews)
            //Set Up Reviews
            
            if venue.reviews.count > 0 {
                reviewOneName.text = venue.reviews[0].user.name
                reviewOneRating.rating = Double(venue.reviews[0].rating)
                reviewOneContent.text = venue.reviews[0].text
                reviewImageOne.image = venue.reviews[0].user.imageState == .downloaded ? venue.reviews[0].user.image! : #imageLiteral(resourceName: "placeholder")
                downloadPhotoForReview(venue.reviews[0], atIndexPath: 0)
            }
            if venue.reviews.count > 1 {
                reviewTwoName.text = venue.reviews[1].user.name
                reviewTwoRating.rating = Double(venue.reviews[1].rating)
                reviewTwoContent.text = venue.reviews[1].text
                reviewImageTwo.image = venue.reviews[1].user.imageState == .downloaded ? venue.reviews[1].user.image! : #imageLiteral(resourceName: "placeholder")
                downloadPhotoForReview(venue.reviews[1], atIndexPath: 1)
            }
            
            if venue.reviews.count > 2 {
                reviewThreeName.text = venue.reviews[2].user.name
                reviewThreeRating.rating = Double(venue.reviews[2].rating)
                reviewThreeContent.text = venue.reviews[2].text
                reviewImageThree.image = venue.reviews[2].user.imageState == .downloaded ? venue.reviews[2].user.image! : #imageLiteral(resourceName: "placeholder")
                downloadPhotoForReview(venue.reviews[2], atIndexPath: 2)
            }
        }
    }

    //MARK: Add To Itinerary Action
    @IBAction func addToItinerary(_ sender: Any) {
        if let alert = alert {
            present(alert, animated: true, completion: nil)
        } else {
            print("It hasn't been initialised yet.")
        }
        
    }
    
 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func downloadPhotoForReview(_ review: YelpReview, atIndexPath indexPath: Int) {
        guard let url = URL(string: review.user.imageUrl) else {
            return
        }
        
        let imageData = try! Data(contentsOf: url)
        
        //Check the byte count to make sure it exists.
        if imageData.count > 0 {
            review.user.image = UIImage(data: imageData)
            review.user.imageState = .downloaded
            switch indexPath {
            case 0: reviewImageOne.image = review.user.image
            case 1: reviewImageTwo.image = review.user.image
            case 2: reviewImageThree.image = review.user.image
            default: return
            }
        } else {
            review.user.imageState = .failed
        }
    }
    
    var alert: UIAlertController?
    
    func configureAlert(with itineraries: [Itinerary] ) {
        if itineraries.count > 0 {
            //Initialise the Button
            saveToItineraryButton.isEnabled = true
            saveToItineraryButton.alpha = 1
            //Initialise the alert
            alert = UIAlertController(title: "\n Choose Itinerary", message: "Select an itinerary from the list below to add this venue to it.", preferredStyle: .actionSheet)
            let height:NSLayoutConstraint = NSLayoutConstraint(item: alert!.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: self.view.frame.height * 0.80)
            alert!.view.addConstraint(height);
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd MMM"
            
            for itinerary in itineraries {
                let itineraryAction = UIAlertAction(title: "\(itinerary.name) • \(dateFormatterPrint.string(from: itinerary.startDate)) → \(dateFormatterPrint.string(from: itinerary.endDate))", style: .default) { (alert: UIAlertAction!) -> Void in
                    
                    self.ref.child("users/\(self.userId)/itineraries/\(itinerary.id)/places").observeSingleEvent(of: .value, with: { (snapshot) in
                        let count = snapshot.childrenCount
                        
                        self.ref.child("users/\(self.userId)/itineraries/\(itinerary.id)/places").child("\(count)").setValue(self.venue!.id)
                    })
                    
                    print("\(itinerary.id)")
                }
                
                alert!.addAction(itineraryAction)
            }
        
            //Cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            }
            alert!.addAction(cancelAction)
        } else {
            saveToItineraryButton.isEnabled = false
            saveToItineraryButton.alpha = 0.5
            saveToItineraryButton.setTitle("No Itineraries Found", for: .disabled)
        }
    }
}
