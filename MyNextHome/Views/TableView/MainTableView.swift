//
//  MainTableView.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 29.06.21.
//

import Foundation
import UIKit

class MainTableView: UITableView {
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.allowsSelection = false
        self.backgroundColor = Colors.mainBackground
        self.separatorStyle = .none
        self.contentInset.top = Constants.Cell.tableTopInset
    }
    
    
    func setContrains(view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




