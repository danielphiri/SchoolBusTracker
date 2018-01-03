//
//  Address.swift
//  SchoolBusTracker
//
//  Created by Daniel Phiri on 12/27/17.
//  Copyright © 2017 Cophiri. All rights reserved.
//

import Foundation
import CoreLocation

class Address {
    var country = String()
    var zip = Int()
    var state = String()
    var city = String()
    var street = String()
    
    init(country: String, zip: Int, state: String, city: String, street: String) {
        self.country = country
        self.zip = zip
        self.state = state
        self.city = city
        self.street = street
    }
    
    func verifyZip() throws {
        
    }
}

enum ZipCodeError: Error {
    case cool
    case not
}
