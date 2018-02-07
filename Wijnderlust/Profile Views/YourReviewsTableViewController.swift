//
//  YourReviewsTableViewController.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 02/02/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class YourReviewsTableViewController: UITableViewController {
    
    // MARK: - Table view data source
    let userID = Auth.auth().currentUser?.uid
    var reviewCount: Int = 0
    var usersReviews = [Review]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        var numOfSections: Int = 0
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = "You Haven't Left Any Reviews Yet!"
        noDataLabel.textColor = UIColor.init(displayP3Red: 142/255.0, green: 142/255.0, blue: 142/255.0, alpha: 1)
        noDataLabel.textAlignment = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as? ReviewCell else { fatalError() }
        
        reviewCell.reviewLabel.text = "Test \(indexPath.row)"

        return reviewCell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    // MARK: - Retrieve Reviews Function
    
//    func retrieveReviews(){
//        ref.queryOrdered(byChild: "reviewDate").observe(.childAdded, with: {
//            (snapshot) in
//
//            if let dictionary = snapshot.value as? [String:AnyObject]{
//
//                var review = Review().setValuesForKeys(dictionary)
//
//                self.usersReviews.append(review)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        })
//    }
    
    // MARK: - Query database and see if the table needs a section.
    //Query DB to see if there is data.
//    ref.child("users").child(userID!).child("reviews").observe(DataEventType.value, with: { (snapshot) in
//    if let reviews = snapshot.value as? [String: AnyObject] {
//    //Reviews exists and is ready to be populated.
//    numOfSections       = 1
//    } else {
//    //Reviews is empty.
//    }
//    }) { (error) in
//    self.showAlertWith(title: "Something Went Wrong!", message: "\(error.localizedDescription)")
//    }

}
