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
    
    // GET
    func retrieveItem(id: Float) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Could not load Appdelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id.description)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "id") as! Float)
                print("retrieveItem(id: Float): TRUE")
                return true
                
            }
        } catch {
            print("Failed")
           
           
        }
        print("retrieveItem(id: Float): FALSE")
        return false
        
    }
    
    // DELETE
    func deleteEntity(for title: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        do {
            print("Deleting")
            let result = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = result[0] as! NSManagedObject
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
    
    func deleteAll() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        //fetchRequest.predicate = NSPredicate(format: "id = %@", id.description)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            print("Deleting all")
            try managedContext.execute(deleteRequest)
       
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    
    func isFavorited(id: Float) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Could not load Appdelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "id == %f", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [FavoritedItem] {
                print(data.value(forKey: "title") as! String)
                print("isFavorited(geoLocation: String): TRUE")
                return true
                
            }
        } catch {
            print("Failed")
           
           
        }
        //print("isFavorited(geoLocation: String): FALSE")
        return false
        
    }
    
    //Save image for Cache
    func saveImage(id: Float, data: Data) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Could not load Appdelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "id == %f", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for item in result as! [FavoritedItem] {
                let nsData = NSData(data: data)
                item.setValue(nsData , forKey: Constants.Entity.realStateImage)
                print(item.value(forKey: "id") as! Float)
                print("🛑saveImage: TRUE")
                
            }
        } catch {
            print("Failed")
        }
        
    }
    
    func getImage(id: Float) -> Data? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            preconditionFailure("Could not load Appdelegate")
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedItem")
        fetchRequest.predicate = NSPredicate(format: "id == %f", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for item in result as! [FavoritedItem] {
                print(item.value(forKey: "id") as! Float)
                print("getImage: TRUE")
                print("RealStateImage: \(String(describing: item.realStateImage))")
                
                guard let itemData = item.realStateImage else { return nil }
                let img = Data(referencing: itemData)
                return img
            }
        } catch {
            print("Failed")
        }
        return nil
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
