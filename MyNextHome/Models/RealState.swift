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
    //var price: Float
    var description: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case title, street, zip, city, geoLocation, description //price
        case id = "advertisementId"
        case imageURL = "picFilename1"
    }
    
    static let `default` = RealState(id: 12345, title: "Oh oh Error", street: "", zip: "", city: "", geoLocation: "",  description: "", imageURL:"")
}

extension RealState: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Float.self, forKey: .id)
        imageURL = try values.decode(String.self, forKey: .imageURL)
        title = try values.decode(String.self, forKey: .title)
        street = try values.decode(String.self, forKey: .street)
        zip = try values.decode(String.self, forKey: .zip)
        city = try values.decode(String.self, forKey: .city)
        geoLocation = try values.decode(String.self, forKey: .geoLocation)
        //price = try values.decode(Float.self, forKey: .price)
        description = try values.decode(String.self, forKey: .description)
        imageURL = try values.decode(String.self, forKey: .imageURL)
    }
}





