//
//  RealState.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation

struct RealState: Codable {
    var id: UUID
    var title: String
    var street: String
    var zip: String
    var city: String
    var geolocation: String
    var price: Float
    var description: String
    var pic1Filename: String
    
}



