//
//  User.swift
//  Wijnderlust
//
//  Created by Matt Gibbs on 30/01/2018.
//  Copyright © 2018 MG Creative Services. All rights reserved.
//

import Foundation

struct User {
    var id: String
    let firstName: String
    let lastName: String

    var emailAddress: String
    var password: String

    let service = "Wijnderlust"
    var account: String { return id }
    var data: [String: Any] {
        return [
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "emailAddress": emailAddress,
            "password": password
        ]
    }
}



