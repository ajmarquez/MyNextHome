//
//  FavoritedItem+CoreDataProperties.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 30.06.21.
//
//

import Foundation
import CoreData


extension FavoritedItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritedItem> {
        return NSFetchRequest<FavoritedItem>(entityName: "FavoritedItem")
    }

    @NSManaged public var city: String
    @NSManaged public var currency: String
    @NSManaged public var geoLocation: String?
    @NSManaged public var id: Float
    @NSManaged public var imageURL: String?
    @NSManaged public var itemDescription: String
    @NSManaged public var price: Float
    @NSManaged public var street: String
    @NSManaged public var title: String
    @NSManaged public var zip: String?

}

extension FavoritedItem : Identifiable {

}
