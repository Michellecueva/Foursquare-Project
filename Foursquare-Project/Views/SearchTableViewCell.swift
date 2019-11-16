//
//  SearchTableViewCell.swift
//  Foursquare-Project
//
//  Created by Michelle Cueva on 11/4/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel = {
           let label = UILabel()
           return label
    }()
    
    lazy var venueImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
       
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: "VenueCell")
           setupVenueImageView()
           setupNameLabel()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Constraint Functions
       
       private func setupVenueImageView() {
           addSubview(venueImage)
           venueImage.translatesAutoresizingMaskIntoConstraints =  false
           NSLayoutConstraint.activate(
               [venueImage.heightAnchor.constraint(equalTo: self.heightAnchor),
                venueImage.widthAnchor.constraint(equalTo: venueImage.heightAnchor),
                venueImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
       }
    
    private func setupNameLabel() {
            let padding: CGFloat = 16
           addSubview(nameLabel)
           nameLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [nameLabel.leadingAnchor.constraint(equalTo: venueImage.trailingAnchor, constant: padding),
                nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                   nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
       }
}
