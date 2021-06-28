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
    func getHeightofRows() -> Int
}

final class ListViewController: UIViewController {
    
    
    var viewModel: RealStateViewModel
    let tableView = UITableView()
    var array: [RealState] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
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
    }
    
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        cell.realState = array[indexPath.row]
        print("From the cell: \(array[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.getHeightofRows())
    }
    
}

extension ListViewController {
    func bindViewModel() {
        viewModel.$array
            .receive(on: DispatchQueue.main)
            .sink { [weak self] array in
                self?.array = array
                print("bindViewModel: This is the array:\(array)")
            }
            .store(in: &cancellables)
    }
}
