//
//  Helper Methods.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 30/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation
import UIKit

let textFieldColor = UIColor(displayP3Red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
let wijnderlustRed = UIColor(red: 149/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
let inactiveRed = UIColor(red: 226/255.0, green: 191/255.0, blue: 191/255.0, alpha: 1.0)

extension UITextField {
    func underlined() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = textFieldColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

//Alert Method
extension UIViewController {
    public func showAlertWith(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//Set 'Is Logged In'
extension UserDefaults {
    
    func setCurrentUser(id: String) {
        set(id, forKey: "userId")
    }
    
    func getCurrentUserId() -> String {
        if let userId = string(forKey: "userId") {
            return userId
        }
        
        return ""
    }
    
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: "isLoggedIn")
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: "isLoggedIn")
    }
}
