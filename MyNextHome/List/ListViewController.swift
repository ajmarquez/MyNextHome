//
//  ListViewController.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit

protocol ListViewDelegate {
    func didSelectItem()
    func reloadListData()
}


class ListViewController: UIViewController {
    
    var listDelegate: ListViewDelegate!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()

        
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
