//
//  FavoritesRepository.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 29.06.21.
//

import Foundation
import UIKit
import CoreData


struct FavoritesRepository {
    
    typealias RealStateList = [RealState]
    
    // CREATE
    func createData(realState: RealState) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let favoritedEntity = NSEntityDescription.entity(forEntityName: "FavoritedItem", in: managedContext) else {
            print("ERROR: entity not found")
            return
            
        }
        
        let favorited = NSManagedObject(entity: favoritedEntity, insertInto: managedContext)
        FavoritesRepository.decodeFromRealState(realState, with: favorited)
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("ERROR: Could not Save \(error), \(error.userInfo)")
        }
    }
    
    
    // GET
    func retrieveData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! String)
            }
        } catch {
            print("Failed")
        }
    }
    
    // DELETE
    func deleteEntity(for id: Float) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.description)
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}



extension FavoritesRepository {
    static func decodeFromRealState(_ realState: RealState, with managedObject: NSManagedObject ) {
        managedObject.setValue(realState.id, forKey: Constants.Entity.id)
        managedObject.setValue(realState.title, forKey: Constants.Entity.title)
        managedObject.setValue(realState.street, forKey: Constants.Entity.street)
        managedObject.setValue(realState.zip, forKey: Constants.Entity.zip)
        managedObject.setValue(realState.city, forKey: Constants.Entity.city)
        managedObject.setValue(realState.geoLocation, forKey: Constants.Entity.geoLocation)
        managedObject.setValue(realState.price, forKey: Constants.Entity.price)
        managedObject.setValue(realState.description, forKey: Constants.Entity.itemDescription)
        managedObject.setValue(realState.imageURL, forKey: Constants.Entity.imageURL)
        managedObject.setValue(realState.currency, forKey: Constants.Entity.currency)
    }
    

}
