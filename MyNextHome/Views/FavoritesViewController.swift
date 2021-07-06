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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.loadData(delegate: self)
        tableView.reloadData()
        self.title = Constants.Navigation.favorites
    }
    
    override func viewDidLoad() {
        viewModel.loadData(delegate: self)
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.setContrains(view: self.view)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")

        
        
    }

   
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let array = viewModel.fetchedResultsController.fetchedObjects else { return 0 }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        
        let item = viewModel.fetchedResultsController.object(at: indexPath)
        cell.setPriceLabelText(currency: item.currency, price: item.price)
        cell.setTitleText(title: item.title)
        cell.setDetailsLabelText(street: item.street, city: item.city)
        
        return cell
    }
    
    //TableView Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Cell.mainCellsize + 10
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.Cell.imageMargin
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ListViewCell else { return } 
        let item = viewModel.fetchedResultsController.object(at: indexPath)
        self.implementCaching(for: cell, at: indexPath, for: item)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let item = viewModel.fetchedResultsController.object(at: indexPath)
        if editingStyle == .delete {
            viewModel.deleteItem(with: item.title) 
            tableView.reloadData()
        }
    }
    
    
    //FetchedResult Delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
                tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
                tableView.moveRow(at: indexPath!, to: newIndexPath!)
        @unknown default:
            print("Error executing action")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

extension FavoritesViewController {
    func implementCaching(for cell: ListViewCell,at indexPath: IndexPath, for item: FavoritedItem) {
        
        
        if let itemImageData = viewModel.getImage(for: item.id) {
            cell.realStateImage.image = UIImage(data: itemImageData) 
        } else {
            
            if let image = item.imageURL  {
                UIImage.getRealStateImage(from: image) { [weak self] image in
                    guard let image = image else { return }
                    cell.realStateImage.image = image
                    print("downloads image")
                    self?.viewModel.saveImage(id: item.id, with: image.pngData())
                }
                
                
            } else {
                cell.realStateImage.image = UIImage(named: Constants.Images.placeholder)
            }
        }
    }
}
