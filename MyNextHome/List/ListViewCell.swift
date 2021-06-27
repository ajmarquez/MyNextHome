//
//  ListViewCell.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 27.06.21.
//

import Foundation
import UIKit

class ListViewCell: UITableViewCell {
    
    var realState: RealState? {
        didSet {
            priceLabel.text = priceLabelText(realState)
            detailsLabel.text = detailsLabelText(realState)
            headlineLabel.text = realState?.title ?? "Error"
            
        }
    }
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainFont
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    
    private var headlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainFont
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    private var detailsLabel: UILabel = {
        let label =  UILabel()
        label.textColor = Colors.mainFont
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.mainBackground
    
      view.clipsToBounds = true
      return view
    }()
    
    private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "placeholder")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(image)
        containerView.addSubview(priceLabel)
        containerView.addSubview(headlineLabel)
        containerView.addSubview(detailsLabel)
        self.contentView.addSubview(containerView)
        
  
        image.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        containerView.topAnchor.constraint(equalTo: image.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Contrains of inner labels
        priceLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        headlineLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor).isActive = true
        headlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        headlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        detailsLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

    }
    
}

extension ListViewCell {
    
    //Buils compound Labels
    func priceLabelText(_ item: RealState?) -> String {
        guard let item = item else {
            return("Error creating String")
        }
        
        return (item.currency + " " + item.price.description)
    }
    
    func detailsLabelText(_ item: RealState?) -> String {
        guard let item = item else {
            return("Error creating String")
        }
        
        return(item.street + ", " + item.city)
    }
    
}
