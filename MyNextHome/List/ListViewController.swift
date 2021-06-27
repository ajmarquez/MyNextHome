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
    let demoArray = RealState.demoArray
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(demoArray)
        tableView.dataSource = self
        tableView.delegate = self
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
        demoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListViewCell
        cell.realState = demoArray[indexPath.row]
        print(demoArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
