//
//  FavoritesViewController.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit
import CoreData

final class FavoritesViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    let tableView = MainTableView()
    let viewModel: FavoritesViewModel
    
    private var container: NSPersistentContainer!
    
    
    init(with viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        viewModel.loadSaveData(delegate: self)
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.setContrains(view: self.view)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
//    func loadSaveData() {
//        if fetchedResultsController == nil {
//            let request:  NSFetchRequest<FavoritedItem> = FavoritedItem.fetchRequest()
//            fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//            fetchedResultsController.delegate = self
//        }
//
//        do {
//            try fetchedResultsController.performFetch()
//            tableView.reloadData()
//        } catch {
//            print("Failed")
//        }
//    }
    
   
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = viewModel.fetchedResultsController.fetchedObjects else { return 0 }
        print(array)
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellList", for: indexPath) as! ListViewCell 
        
        let item = viewModel.fetchedResultsController.object(at: indexPath) as FavoritedItem
        print(item.city)
        
        return cell
    }
}
