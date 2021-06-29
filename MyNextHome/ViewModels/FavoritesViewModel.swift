//
//  FavoritesViewModel.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 29.06.21.
//

import Foundation
import CoreData

class FavoritesViewModel {
    
    var fetchedResultsController: NSFetchedResultsController<FavoritedItem>!
    private var container: NSPersistentContainer!
    
    
    init(with container: NSPersistentContainer) {
        self.container = container
    }
    
    func loadSaveData(delegate: NSFetchedResultsControllerDelegate) {
        if fetchedResultsController == nil {
            let request:  NSFetchRequest<FavoritedItem> = FavoritedItem.fetchRequest()
            let sort = NSSortDescriptor(key: "title", ascending: false)
                    request.sortDescriptors = [sort]
            request.fetchBatchSize = 20
            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchedResultsController.delegate = delegate
        }
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Failed")
        }
    }
    
    
    func deleteItem(with id: Float) {
        FavoritesRepository().deleteEntity(for: id)
    }
    
}
