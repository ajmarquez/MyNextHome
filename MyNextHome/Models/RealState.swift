//
//  RealState.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation

struct RealState {
    var id: Float
    var title: String
    var street: String
    var zip: String
    var city: String
    var geoLocation: String
    var price: Float
    var description: String
    var imageURL: String
    var currency: String
    
    enum CodingKeys: String, CodingKey {
        case title, street, zip, city, geoLocation, description, currency
        case id = "advertisementId"
        case imageURL = "picFilename1"
        case price = "sellingPrice"
    }
    
    static let `default` = RealState(id: 12345, title: "Oh oh Error", street: "", zip: "", city: "", geoLocation: "", price: 12345, description: "", imageURL: "", currency: "EUR")
}

extension RealState: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Float.self, forKey: .id)
        price = try values.decodeIfPresent(Float.self, forKey: .price) ?? 0
        imageURL = try values.decode(String.self, forKey: .imageURL)
        title = try values.decode(String.self, forKey: .title)
        street = try values.decode(String.self, forKey: .street)
        zip = try values.decode(String.self, forKey: .zip)
        city = try values.decode(String.self, forKey: .city)
        geoLocation = try values.decode(String.self, forKey: .geoLocation)
        description = try values.decode(String.self, forKey: .description)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        currency = try values.decode(String.self, forKey: .currency)
    }
}


extension RealState {
    static let demoArray = [
        RealState(id: 123, title: "Rent House 01", street: "Usedomer Str.10", zip: "13355", city: "Berlin", geoLocation: "", price: 1234456, description: "", imageURL: "", currency: "EUR"),
        RealState(id: 123, title: "Rent House 01", street: "Usedomer Str.10", zip: "13355", city: "Berlin", geoLocation: "", price: 1234456, description: "", imageURL: "", currency: "EUR"),
        RealState(id: 123, title: "Rent House 01", street: "Usedomer Str.10", zip: "13355", city: "Berlin", geoLocation: "", price: 1234456, description: "", imageURL: "", currency: "EUR"),
        RealState(id: 123, title: "Rent House 01", street: "Usedomer Str.10", zip: "13355", city: "Berlin", geoLocation: "", price: 1234456, description: "", imageURL: "", currency: "EUR")
    ]
}







