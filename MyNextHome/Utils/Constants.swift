//
//  Constants.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 29.06.21.
//

import Foundation
import UIKit

struct Constants {
    //Cell contants
    struct Cell {
        static let cornerRadius: CGFloat = 20
        static let imageMargin: CGFloat = 15
        static let mainCellsize: CGFloat = 450
        static let tableTopInset: CGFloat = 20
    }
    
    //CoreData Constants
    struct Entity {
        static let id = "id"
        static let title = "title"
        static let street = "street"
        static let zip = "zip"
        static let city = "city"
        static let geoLocation = "geoLocation"
        static let imageURL = "imageURL"
        static let currency = "currency"
        static let price = "price"
        static let itemDescription = "itemDescription"
        static let isFavorited = "isFavorited"
    }
    
    struct Images {
        static let heartFull = "heartFull"
        static let heartEmpty = "heartEmpty"
    }
    
    
}
