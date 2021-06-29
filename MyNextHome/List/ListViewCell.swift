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
        label.textColor = Colors.mainText
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    
    private var headlineLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.mainText
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    private var detailsLabel: UILabel = {
        let label =  UILabel()
        label.textColor = Colors.subtitleText
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    let containerView:UIView = {
        let view =  UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.Cell.cornerRadius
        view.clipsToBounds = true
        
        return view
    }()
    
    let labelContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
    }()
    
    var realStateImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "placeholder")
        image.layer.cornerRadius = Constants.Cell.cornerRadius
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.realStateImage.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = Colors.mainBackground
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(realStateImage)
        labelContainerView.addSubview(priceLabel)
        labelContainerView.addSubview(headlineLabel)
        labelContainerView.addSubview(detailsLabel)
        contentView.addSubview(labelContainerView)
        
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: Constants.Cell.mainCellsize - 10).isActive = true
        
        
        realStateImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.Cell.imageMargin).isActive = true
        realStateImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.Cell.imageMargin).isActive = true
        realStateImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.Cell.imageMargin * -1).isActive = true
        realStateImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        labelContainerView.topAnchor.constraint(equalTo: realStateImage.bottomAnchor).isActive = true
        labelContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        labelContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        labelContainerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        //Contrains of inner labels
        priceLabel.topAnchor.constraint(equalTo: labelContainerView.topAnchor, constant: 20).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 15).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor).isActive = true
        
        headlineLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true
        headlineLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 15).isActive = true
        headlineLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor).isActive = true
        
        detailsLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 5).isActive = true
        detailsLabel.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 15).isActive = true
        detailsLabel.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor).isActive = true
        
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
    
    func loadImage(with realState: RealState?) {
        
        guard let realState = realState else { return }
        UIImage.realStateImage(from: realState, completion: { [weak self] image in
            self?.realStateImage.image = image
        })
    }
    
}
