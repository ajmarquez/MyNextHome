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

final class ListViewController: UIViewController {
    
    
    var viewModel: RealStateViewModel
    let tableView = UITableView()
    var array: [RealState] = [] {
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.allowsSelection = false
        tableView.backgroundColor = Colors.mainBackground
        tableView.separatorStyle = .none
        tableView.contentInset.top = Constants.Cell.tableTopInset
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        
        let itemNumber = NSNumber(value: indexPath.item)
        
        if let cachedImage = self.cache.object(forKey: itemNumber) {
            print("Using a cached image for item: \(itemNumber)")
            cell.realStateImage.image = cachedImage
        } else {
            self.loadImage(with: array[indexPath.row]) { [weak self] (image) in
                guard let self = self, let image = image else { return }
                
                cell.realStateImage.image = image
                self.cache.setObject(image, forKey: itemNumber)
            }
        }
    }
}



extension ListViewController {
    
    //Used to binf the viewModel and the ViewController together
    func bindViewModel() {
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] array in
                self?.array = array
                print("bindViewModel: This is the array:\(array)")
            }
            .store(in: &cancellables)
    }
    
    //SPECIAL CASE: Load image using a re-formated URL for images
    func loadImage(with model: RealState, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            let url = HomegateAPI.getImageURL(for: model)
            
            guard let data = try? Data(contentsOf: url) else { return }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
}
