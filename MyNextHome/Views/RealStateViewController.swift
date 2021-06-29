//
//  ListViewController.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit
import Combine

protocol ListViewModel {
    func getRealStateList()
}

final class RealStateViewController: UIViewController {
    
    
    var viewModel: RealStateViewModel
    let tableView = MainTableView()
    lazy var array: [RealState] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    private let cache = NSCache<NSNumber, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    private var cancellables: Set<AnyCancellable> = []
    
    init(with viewModel: RealStateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       bindViewModel()

       //Set Delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        //Add table
        setTableView()
        tableView.register(ListViewCell.self, forCellReuseIdentifier: "listCell")
    }
    
    func setTableView() {
        view.addSubview(tableView)
        tableView.setContrains(view: self.view)
    }
    
}

extension RealStateViewController: UITableViewDataSource, UITableViewDelegate {
    
    //TableView Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        cell.realState = array[indexPath.row]
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
        
        self.implementCaching(for: cell, at: indexPath)
    }
}

// MARK: - Utility methods

extension RealStateViewController {
    
    //Used to bind the viewModel and the ViewController together
    func bindViewModel() {
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] array in
                self?.array = array
            }
            .store(in: &cancellables)
    }
    
    //Used to implement cache on the images
    func implementCaching(for cell: ListViewCell,at indexPath: IndexPath) {
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            cell.realStateImage.image = cachedImage
        } else {
            UIImage.loadImage(with: array[indexPath.row],dispatchQueue: utilityQueue ) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.realStateImage.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
    }

}
