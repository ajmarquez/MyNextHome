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
    private let repository = FavoritesRepository()
    
    
    init(with container: NSPersistentContainer) {
        self.container = container
    }
    
    func loadData(delegate: NSFetchedResultsControllerDelegate) {
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
    
    
    func saveImage(id: Float, with data: Data?){
        guard let data = data else {return}
        repository.saveImage(id: id, data: data)
    }
    
    func getImage(for id: Float) -> Data? {
        return repository.getImage(id: id)
    }
    
    
    func deleteItem(with title: String) {
        repository.deleteEntity(for: title)
    }
    
}
